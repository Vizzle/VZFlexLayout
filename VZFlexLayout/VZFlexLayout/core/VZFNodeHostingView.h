//
//  VZFNodeHostingView.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFSizeRange.h"
#import "VZFNodeProvider.h"
#import "VZFStateUpdateMode.h"

@class VZFNodeHostingView;
@class VZFNode;

@protocol VZFNodeHostingView <NSObject>

@optional

- (void)hostingView:(VZFNodeHostingView* )view DidInvalidate:(CGSize)newSize;

@end

/**
 *  HostingView用来承载RootNode
 *
 *  @discussion:如果需要考虑view复用的场景，不建议使用hostingview
 *  tableView cell复用的场景请使用VZFNodeListItemRecycler
 *
 */
@interface VZFNodeHostingView : UIView

@property(nonatomic,weak)id<VZFNodeHostingView> delegate;


- (id)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider RangeProvider:(id<VZSizeRangeProvider>)sizeProvider;

/**
 *  更新hostingview的数据
 *
 *  @param model      被更新的数据
 *  @param updateMode 同步/异步更新
 *
 *  @discussion: 如果是异步更新，node创建和layout将会在异步线程中执行
 *
 */
- (void)update:(id)model mode:(VZFStateUpdateMode)updateMode;
- (void)reset;

- (instancetype)init __attribute__((unavailable("Not the designated initializer")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Not the designated initializer")));


@end
