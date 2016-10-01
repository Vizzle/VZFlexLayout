//
//  VZFAsyncDrawingTransactionInterface.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, VZFAsyncTransactionContainerState) {
    /**
     The async container has no outstanding transactions.
     Whatever it is displaying is up-to-date.
     */
     kNoTransactions = 0,
    /**
     The async container has one or more outstanding async transactions.
     Its contents may be out of date or showing a placeholder, depending on the configuration of the contained AsyncLayer.
     */
    kPendingTransaction = 1,
};


@protocol VZFAsyncDrawingTransactionInterface <NSObject>

/**
 @summary If YES, the receiver is marked as a container for async display, grouping all of the async display calls
 in the layer hierarchy below the receiver together in a single CKAsyncTransaction.
 
 @default NO
 */
@property (nonatomic, assign) BOOL isAsyncTransactionContainer;

/**
 @summary The current state of the receiver; indicates if it is currently performing asynchronous operations or if all operations have finished/canceled.
 */
@property (nonatomic, assign, readonly) VZFAsyncTransactionContainerState asyncTransactionContainerState;

/**
 @summary Cancels all async transactions on the receiver.
 */
- (void)vz_cancelAsyncTransactions;

/**
 @summary Invoked when the ck_asyncTransactionContainerState property changes.
 @desc You may want to override this in a CALayer or UIView subclass to take appropriate action (such as hiding content while it renders).
 */
- (void)vz_asyncTransactionContainerStateDidChange;

@end
