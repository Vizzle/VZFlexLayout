//
//  VZFAsyncDrawingTransaction.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFAsyncDrawingTransaction.h"
#import "VZFMacros.h"

@interface VZFAsyncDrawingTransactionOperation : NSObject

@property (nonatomic, copy) vz_async_transaction_completion_block_t operationCompletionBlock;
@property (atomic, retain) id<NSObject> value; // set on bg queue by the operation block

- (id)initWithOperationCompletionBlock:(vz_async_transaction_completion_block_t)operationCompletionBlock;
- (void)callAndReleaseCompletionBlock:(BOOL)canceled;

@end

@implementation VZFAsyncDrawingTransactionOperation


- (id)initWithOperationCompletionBlock:(vz_async_transaction_completion_block_t)operationCompletionBlock
{
    if ((self = [super init])) {
        _operationCompletionBlock = [operationCompletionBlock copy];
    }
    return self;
}

- (void)dealloc
{
    VZFAssertNil(_operationCompletionBlock, @"Should have been called and released before -dealloc");
}

- (void)callAndReleaseCompletionBlock:(BOOL)canceled
{
    if (_operationCompletionBlock) {
        _operationCompletionBlock(self.value, canceled);
        // Guarantee that _operationCompletionBlock is released on _callbackQueue:
        self.operationCompletionBlock = nil;
    }
}

@end

@implementation VZFAsyncDrawingTransaction
{
    dispatch_group_t _group;
    NSMutableArray<VZFAsyncDrawingTransactionOperation* >* _operations;
}


- (id)initWithCallbackQueue:(dispatch_queue_t)callbackQueue completionBlock:(vz_async_transaction_completion_block_t)completionBlock
{
    if ((self = [self init])) {
        if (callbackQueue == NULL) {
            callbackQueue = dispatch_get_main_queue();
        }
        _callbackQueue = callbackQueue;
        _completionBlock = [completionBlock copy];
        
        _state = VZFAsyncTransactionStateOpen;
    }
    return self;
}

- (void)dealloc
{
    // Uncommitted transactions break our guarantees about releasing completion blocks on callbackQueue.
    VZFCAssert(_state != VZFAsyncTransactionStateOpen, @"Uncommitted CKAsyncTransactions are not allowed");
}

- (void)addSyncDrawingOperation:(vz_async_display_block_t)block
                          queue:(dispatch_queue_t)queue
                     completion:(vz_async_completion_block_t)completion{

    
    VZFAssertMainThread();
    VZFCAssert(_state == VZFAsyncTransactionStateOpen, @"You can only add operations to open transactions");
    
    [self _ensureTransactionData];
    
    VZFAsyncDrawingTransactionOperation *operation = [[VZFAsyncDrawingTransactionOperation alloc] initWithOperationCompletionBlock:completion];
    [_operations addObject:operation];
    dispatch_group_async(_group, queue, ^{
        if (_state != VZFAsyncTransactionStateCanceled) {
            operation.value = block();
        }
    });
}

- (void)addAsyncTransactionOperation:(vz_async_transaction_operation_block_t)block
                               queue:(dispatch_queue_t)queue
                          completion:(vz_async_completion_block_t)completion{
    
    VZFAssertMainThread();
    VZFCAssert(_state == VZFAsyncTransactionStateOpen, @"You can only add operations to open transactions");
    
    [self _ensureTransactionData];
    
    VZFAsyncDrawingTransactionOperation *operation = [[VZFAsyncDrawingTransactionOperation alloc] initWithOperationCompletionBlock:completion];
    [_operations addObject:operation];
    dispatch_group_async(_group, queue, ^{
        if (_state != VZFAsyncTransactionStateCanceled) {
            dispatch_group_enter(_group);
            block(^(id<NSObject> value){
                operation.value = value;
                dispatch_group_leave(_group);
            });
        }
    });
}

- (void)addCompletionBlock:(vz_async_transaction_completion_block_t)completion
{
    __weak VZFAsyncDrawingTransaction* weakSelf = self;
    [self addOperationWithBlock:^(){return (id<NSObject>)nil;} queue:_callbackQueue completion:^(id<NSObject> value, BOOL canceled) {
        __strong VZFAsyncDrawingTransaction* strongSelf = weakSelf;
        completion(strongSelf, canceled);
    }];
    
}


- (void)addOperationWithBlock:(vz_async_display_block_t)block
                        queue:(dispatch_queue_t)queue
                   completion:(vz_async_completion_block_t)completion
{
    VZFAssertMainThread();
    VZFAssert(_state == VZFAsyncTransactionStateOpen, @"You can only add operations to open transactions");
    
    [self _ensureTransactionData];
    
    VZFAsyncDrawingTransactionOperation *operation = [[VZFAsyncDrawingTransactionOperation alloc] initWithOperationCompletionBlock:completion];
    [_operations addObject:operation];
    dispatch_group_async(_group, queue, ^{
        if (_state != VZFAsyncTransactionStateCanceled) {
            operation.value = block();
        }
    });
}


- (void)cancel
{
    VZFAssertMainThread();
    VZFAssert(_state != VZFAsyncTransactionStateOpen, @"You can only cancel a committed or already-canceled transaction");
    _state = VZFAsyncTransactionStateCanceled;
}


- (void)commit{
    
    VZFAssertMainThread();
    VZFAssert(_state == VZFAsyncTransactionStateOpen, @"You cannot double-commit a transaction");
    _state = VZFAsyncTransactionStateCommitted;
    
    if ([_operations count] == 0) {
        // Fast path: if a transaction was opened, but no operations were added, execute completion block synchronously.
        if (_completionBlock) {
            _completionBlock(self, NO);
        }
    } else {
        VZFAssert(_group != NULL, @"If there are operations, dispatch group should have been created");
        dispatch_group_notify(_group, _callbackQueue, ^{
            BOOL isCanceled = (_state == VZFAsyncTransactionStateCanceled);
            for (VZFAsyncDrawingTransactionOperation *operation in _operations) {
                [operation callAndReleaseCompletionBlock:isCanceled];
            }
            if (_completionBlock) {
                _completionBlock(self, isCanceled);
            }
        });
    }

}


#pragma mark - private Methods

- (void)_ensureTransactionData
{
    // Lazily initialize _group and _operations to avoid overhead in the case where no operations are added to the transaction
    if (_group == NULL) {
        _group = dispatch_group_create();
    }
    if (_operations == nil) {
        _operations = [[NSMutableArray alloc] init];
    }
}


@end
