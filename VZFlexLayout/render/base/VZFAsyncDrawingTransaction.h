//
//  VZFAsyncDrawingTransaction.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


//异步绘制block
typedef id<NSObject>(^vz_async_display_block_t)(void);
//取消block
typedef BOOL(^vz_async_iscancelled_block_t)(void);
//绘制完成block
typedef void(^vz_async_completion_block_t)(id<NSObject> value, BOOL cancelled);

//transaction 完成的block
@class VZFAsyncDrawingTransaction;
typedef void(^vz_async_transaction_completion_block_t)(VZFAsyncDrawingTransaction* transaction, BOOL cancelled);
//transaction operation 完成的block
typedef void(^vz_async_transaction_operation_completion_block_t)(id<NSObject> value);
typedef void(^vz_async_transaction_operation_block_t)(vz_async_transaction_operation_completion_block_t completionBlock);


/**
 State is initially CKAsyncTransactionStateOpen.
 Every transaction MUST be committed. It is an error to fail to commit a transaction.
 A committed transaction MAY be canceled. You cannot cancel an open (uncommitted) transaction.
 */
typedef NS_ENUM(NSUInteger, VZFAsyncTransactionState) {
    VZFAsyncTransactionStateOpen = 0,
    VZFAsyncTransactionStateCommitted,
    VZFAsyncTransactionStateCanceled,
};


@interface VZFAsyncDrawingTransaction : NSObject
/**
 The dispatch queue that the completion blocks will be called on.
 */
@property (nonatomic, retain, readonly) dispatch_queue_t callbackQueue;

/**
 A block that is called when the transaction is completed.
 */
@property (nonatomic, copy, readonly) vz_async_transaction_completion_block_t completionBlock;
/**
 The state of the transaction.
 */
@property (nonatomic, readonly) VZFAsyncTransactionState state;


/**
 创建一个Transaction来调度异步绘制任务

 @param callbackQueue   回调线程
 @param completionBlock 回调block

 */
- (id)initWithCallbackQueue:(dispatch_queue_t)callbackQueue
            completionBlock:(vz_async_transaction_completion_block_t)completionBlock;

/**
 @summary Adds an async operation to the transaction.  The execution block will be executed immediately.
 
 @desc The block will be executed on the specified queue and is expected to complete asynchronously.  The block will be
 supplied with a completion block that can be executed once its async operation is completed.  This is useful for
 network downloads and other operations that have an async API.
 
 WARNING: Consumers MUST call the completeOperationBlock passed into the work block, or objects will be leaked!
 
 @param block The execution block that will be executed on a background queue.  This is where the expensive work goes.
 @param queue The dispatch queue on which to execute the block.
 @param completion The completion block that will be executed with the output of the execution block when all of the
 operations in the transaction are completed. Executed and released on callbackQueue.
 */
- (void)addSyncDrawingOperation:(vz_async_display_block_t)block
                           queue:(dispatch_queue_t)queue
                      completion:(vz_async_completion_block_t)completion;


- (void)addAsyncTransactionOperation:(vz_async_transaction_operation_block_t)block
                               queue:(dispatch_queue_t)queue
                          completion:(vz_async_completion_block_t)completion;



/**
 @summary Adds a block to run on the completion of the async transaction.
 
 @param queue The dispatch queue on which to execute the block.
 @param completion The completion block that will be executed with the output of the execution block when all of the
 operations in the transaction are completed. Executed and released on callbackQueue.
 */

- (void)addCompletionBlock:(vz_async_transaction_completion_block_t)completion;

/**
 @summary Cancels all operations in the transaction.
 
 @desc You can only cancel a commmitted transaction.
 
 All completion blocks are always called, regardless of cancelation. Execution blocks may be skipped if canceled.
 */
- (void)cancel;
/**
 @summary Marks the end of adding operations to the transaction.
 
 @desc You MUST commit every transaction you create. It is an error to create a transaction that is never committed.
 
 When all of the operations that have been added have completed the transaction will execute their completion
 blocks.
 
 If no operations were added to this transaction, invoking commit will execute the transaction's completion block synchronously.
 */
- (void)commit;

@end




