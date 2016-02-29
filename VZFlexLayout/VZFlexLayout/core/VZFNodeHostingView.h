//
//  VZFNodeHostingView.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFSizeRange.h"

@class VZFNode;
@protocol VZFNodeProvider <NSObject>

+ (VZFNode *)nodeForItem:(id<NSObject>)item context:(id<NSObject>)context;

@end

@protocol VZFNodeHostingView <NSObject>

@optional
- (void)hostingViewDidInvalidate:(CGSize)newSize;

@end

@interface VZFNodeHostingView : UIView

@property(nonatomic,weak)id<VZFNodeHostingView> delegate;

- (id)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider RangeProvider:(id<VZSizeRangeProvider>)sizeProvider;
- (void)render:(id)model;
//for test only
- (void)renderWithState:(id)state reuseView:(UIView *)reuseView;

@end
