//
//  VZFAsyncDrawingTransactionContainer.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFAsyncLayer.h"
#import "VZFAsyncDrawingTransactionInterface.h"

@class VZFAsyncDrawingTransaction;
@interface CALayer(AsyncTransactionContainer)<VZFAsyncDrawingTransactionInterface>

@property(nonatomic,retain,readonly) VZFAsyncDrawingTransaction* asyncTransaction;

@property (nonatomic, retain, readonly) CALayer *parentTransactionContainer;

//subclass overrring
- (void)vz_asyncTransactionContainerWillBeginTransaction:(VZFAsyncDrawingTransaction *)transaction;
- (void)vz_asyncTransactionContainerDidCompleteTransaction:(VZFAsyncDrawingTransaction *)transaction;

@end
