//
//  VZFAsyncLayer+VZFAsyncTransaction.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VZFAsyncDrawingTransaction;

@interface CALayer (VZFAsyncTransactionPrivate)

@property (nonatomic, retain) NSHashTable *asyncLayerTransactions;
@property (nonatomic, retain) VZFAsyncDrawingTransaction *currentAsyncTransaction;


@end
