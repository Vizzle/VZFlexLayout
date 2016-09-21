//
//  VZFAsyncDrawingTransactionGroup.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFAsyncDrawingTransactionGroup.h"
#import "VZFAsyncDrawingTransaction.h"
#import "VZFAsyncDrawingTransactionContainer.h"
#import "VZFAsyncDrawingTransactionContainer+Private.h"
#import "VZFMacros.h"



static void vz_transactionGroupRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

@implementation VZFAsyncDrawingTransactionGroup{
    
    NSHashTable<CALayer* > *_containerLayers;
    NSHashTable<CALayer* > *_pendingContainerLayers;
    NSMutableArray<dispatch_block_t> *_pendingCompletionHandlers;

}

+ (instancetype)sharedInstance{

    static VZFAsyncDrawingTransactionGroup* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[VZFAsyncDrawingTransactionGroup alloc]init];
    });
    return instance;
}



- (id)init
{
    if ((self = [super init])) {
        _containerLayers = [[NSHashTable alloc] initWithOptions:NSHashTableStrongMemory|NSHashTableObjectPointerPersonality capacity:0];
        _pendingContainerLayers = [[NSHashTable alloc] initWithOptions:NSHashTableStrongMemory|NSHashTableObjectPointerPersonality capacity:0];
        _pendingCompletionHandlers = [NSMutableArray array];
        [self _registerMainRunloopObserver];
    }
    return self;
}


#pragma mark - public methods


- (void)addTransactionContainer:(CALayer *)containerLayer{

    VZFAssertMainThread();
    VZFAssertNotNil(containerLayer, @"Inserting a nil containerLayer");
    [_containerLayers addObject:containerLayer];
}

/// Remove a transaction container that no longer has pending transactions.
/// All layers added with addTransactionContainer: should be removed with removeTransactionContainer: once all
/// its transactions have been completed or canceled for flushPendingTransactions: to work correctly.
/// Only one call to removeTransactionContainer: is needed to remove the layer, even if addTransactionContainer:
/// has been called multiple times.
/// @param containerLayer A layer for which all transactions have been completed or canceled.
- (void)removeTransactionContainer:(CALayer *)containerLayer{

    VZFAssertMainThread();
    VZFAssertNotNil(containerLayer, @"Removing a nil layer from the group");
    
    [_containerLayers removeObject:containerLayer];
    
    if ([_pendingContainerLayers containsObject:containerLayer]) {
        [_pendingContainerLayers removeObject:containerLayer];
        [self _forceLayoutAndFlushPendingTransactionsIfNeeded];
    }
}

/// Force layout and display and signal when all the pending transactions have completed.
/// When the app is in background mode, UIKit suspends layout and display calls until it takes a screenshot.
/// Call flushPendingTransactions to force async layers to render and display a consistent UI for the snapshot.
/// @param completionHandler A block that is called on the main thread after all transactions have completed.
- (void)flushPendingTransactions:(dispatch_block_t)completionHandler{


}



- (void)commit{

    VZFAssertMainThread();
    
    if ([_containerLayers count]) {
        NSSet *containerLayersToCommit = [_containerLayers copy];
        [_containerLayers removeAllObjects];
        
        for (CALayer *containerLayer in containerLayersToCommit) {
            // Note that the act of committing a transaction may open a new transaction,
            // so we must nil out the transaction we're committing first.
            VZFAsyncDrawingTransaction *transaction = containerLayer.currentAsyncTransaction;
            containerLayer.currentAsyncTransaction = nil;
            [_pendingContainerLayers addObject:containerLayer];
            [transaction commit];
        }
    }
    
}



#pragma mark - private methods


- (void)_forceLayoutAndFlushPendingTransactionsIfNeeded{

    if ([_pendingContainerLayers count] == 0 && [_pendingCompletionHandlers count] != 0) {
        
        [self forceLayoutAndFlushPendingTransactions];
    }


}

- (void)forceLayoutAndFlushPendingTransactions
{
    [self _layoutAndDisplayAllWindowsIfNeeded];
    [self commit];
    
    if ([_pendingContainerLayers count] == 0) {
        NSSet *pendingCompletionHandlers = [_pendingCompletionHandlers copy];
        
        [_pendingCompletionHandlers removeAllObjects];
        
        for (void (^completionHandler)(void) in pendingCompletionHandlers) {
            completionHandler();
        }
    }
}


- (void)_layoutAndDisplayAllWindowsIfNeeded
{
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CALayer *windowLayer = window.layer;
        [self _layoutAndDisplaySublayersOfLayerIfNeeded:windowLayer];
    }
}


- (void)_layoutAndDisplaySublayersOfLayerIfNeeded:(CALayer* )layer{
   
    [layer layoutIfNeeded];
    [self _displaySublayersOfLayerIfNeeded:layer];

}

- (void)_displaySublayersOfLayerIfNeeded:(CALayer *)rootLayer
{
    [rootLayer displayIfNeeded];
    
    for (CALayer *sublayer in rootLayer.sublayers) {
        [self _displaySublayersOfLayerIfNeeded:sublayer];
    }
}


- (void)_registerMainRunloopObserver
{
    VZFAssertMainThread();
    static CFRunLoopObserverRef observer;
    // defer the commit of the transaction so we can add more during the current runloop iteration
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFOptionFlags activities = (kCFRunLoopBeforeWaiting | // before the run loop starts sleeping
                                kCFRunLoopExit);          // before exiting a runloop run
    CFRunLoopObserverContext context = {
        0,           // version
        (__bridge void *)self,  // info
        &CFRetain,   // retain
        &CFRelease,  // release
        NULL         // copyDescription
    };
    
    observer = CFRunLoopObserverCreate(NULL,        // allocator
                                       activities,  // activities
                                       YES,         // repeats
                                       INT_MAX,     // order after CA transaction commits
                                       &vz_transactionGroupRunLoopObserverCallback,  // callback
                                       &context);   // context
    CFRunLoopAddObserver(runLoop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}


@end

static void vz_transactionGroupRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    VZFCAssertMainThread();
    VZFAsyncDrawingTransactionGroup *group = (__bridge VZFAsyncDrawingTransactionGroup *)info;
    [group commit];
}

