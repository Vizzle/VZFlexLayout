//
//  VZFAsyncDrawingTransactionContainer.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFAsyncDrawingTransactionContainer.h"
#import "VZFAsyncDrawingTransactionContainer+Private.h"
#import "VZFAsyncDrawingTransaction.h"
#import "VZFAsyncDrawingTransactionGroup.h"
#import <objc/runtime.h>



const static void* vz_asyncTransactionHashTable = &vz_asyncTransactionHashTable;
const static void* vz_currentAsyncTransaction = &vz_currentAsyncTransaction;
const static void* vz_isAsyncTransactionnContainer = &vz_isAsyncTransactionnContainer;


@implementation CALayer (AsyncTransactionContainer)


//isAsyncTransactionContainer
- (void)setIsAsyncTransactionContainer:(BOOL)isAsyncTransactionContainer{
    objc_setAssociatedObject(self, vz_isAsyncTransactionnContainer, @(isAsyncTransactionContainer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isAsyncTransactionContainer{
    return  [objc_getAssociatedObject(self, vz_isAsyncTransactionnContainer) boolValue];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//currentAsyncTransaction

- (void)setCurrentAsyncTransaction:(VZFAsyncDrawingTransaction *)currentAsyncTransaction{
    objc_setAssociatedObject(self, vz_currentAsyncTransaction, currentAsyncTransaction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VZFAsyncDrawingTransaction* )currentAsyncTransaction{
    return objc_getAssociatedObject(self, vz_currentAsyncTransaction);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//asyncTransactions

- (void)setAsyncLayerTransactions:(NSHashTable *)asyncLayerTransactions{
    objc_setAssociatedObject(self, vz_asyncTransactionHashTable, asyncLayerTransactions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSHashTable* )asyncLayerTransactions{
    return objc_getAssociatedObject(self, vz_asyncTransactionHashTable);
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//transaction container state
- (void)setAsyncTransactionContainerState:(VZFAsyncTransactionContainerState)state{};
- (VZFAsyncTransactionContainerState)asyncTransactionContainerState{
      return ([self.asyncLayerTransactions count] == 0) ? kNoTransactions : kPendingTransaction;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//asyncTransaction

- (void)setAsyncTransaction:(VZFAsyncDrawingTransaction *)asyncTransaction{}
- (VZFAsyncDrawingTransaction* )asyncTransaction{
    
    
    VZFAsyncDrawingTransaction *transaction = self.currentAsyncTransaction;
    if (transaction == nil) {
        
        NSHashTable *transactions = self.asyncLayerTransactions;
        
        if (transactions == nil) {
            
            transactions = [[NSHashTable alloc] initWithOptions:NSHashTableStrongMemory|NSHashTableObjectPointerPersonality capacity:0];
            self.asyncLayerTransactions = transactions;
        }
        
        
        //create a transation
        transaction = [[VZFAsyncDrawingTransaction alloc]initWithCallbackQueue:dispatch_get_main_queue() completionBlock:^(VZFAsyncDrawingTransaction *completedTransaction, BOOL cancelled) {
            
            [transactions removeObject:completedTransaction];
            
            [self vz_asyncTransactionContainerDidCompleteTransaction:completedTransaction];
            
            if (transactions.count == 0) {
                
                [self vz_asyncTransactionContainerStateDidChange];
                [[VZFAsyncDrawingTransactionGroup sharedInstance] removeTransactionContainer:self];
                
            }
        }];
        
        //add to transactions
        [transactions addObject:transaction];
        
        self.currentAsyncTransaction = transaction;
        
        [self vz_asyncTransactionContainerWillBeginTransaction:transaction];
        
        if (transactions.count == 1) {
            
            [self vz_asyncTransactionContainerStateDidChange];
        }
        
    }
    
    [[VZFAsyncDrawingTransactionGroup sharedInstance] addTransactionContainer:self];
    
    return transaction;
}

- (void)setParentTransactionContainer:(CALayer *)parentTransactionContainer{};
//getter @runtime
- (CALayer* )parentTransactionContainer{

    CALayer *containerLayer = self;
    while (containerLayer && !containerLayer.isAsyncTransactionContainer) {
        containerLayer = containerLayer.superlayer;
    }
    return containerLayer;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - subclassing methods

- (void)vz_asyncTransactionContainerWillBeginTransaction:(VZFAsyncDrawingTransaction *)transaction{}
- (void)vz_asyncTransactionContainerDidCompleteTransaction:(VZFAsyncDrawingTransaction *)transaction{}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - protocol methdos

- (void)vz_cancelAsyncTransactions{

    // If there was an open transaction, commit and clear the current transaction. Otherwise:
    // (1) The run loop observer will try to commit a canceled transaction which is not allowed
    // (2) We leave the canceled transaction attached to the layer, dooming future operations
    VZFAsyncDrawingTransaction *currentTransaction = self.currentAsyncTransaction;
    [currentTransaction commit];
    self.currentAsyncTransaction = nil;
    
    for (VZFAsyncDrawingTransaction *transaction in [self.asyncLayerTransactions copy]) {
        [transaction cancel];
    }

}

- (void)vz_asyncTransactionContainerStateDidChange{

    id delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(vz_asyncTransactionContainerStateDidChange)]) {
        [delegate vz_asyncTransactionContainerStateDidChange];
    }

}


@end
