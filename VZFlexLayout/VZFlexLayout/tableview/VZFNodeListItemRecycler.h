//
//  VZFNodeListAdapter.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFSizeRange.h"
#import "VZFNodeLayout.h"
#import "VZFNodeProvider.h"

using namespace VZ;

@class VZFRootScope;

struct VZFNodeListRecycleState{
    
    id item;
    id<NSObject> context;
    CGSize constrainedSize;
    NodeLayout layout;
    VZFRootScope* rootScope;
};

@protocol VZFNodeListItemRecycleController <NSObject>

@optional
- (void)nodeStateDidChanged:(id)scopeId ShouldInvalidateToNewSize:(BOOL)b;


@end


/**
 *  列表node的适配器
 */
@interface VZFNodeListItemRecycler : NSObject

@property(nonatomic,strong) NSIndexPath* indexPath;
@property(nonatomic,weak)id<VZFNodeListItemRecycleController> delegate;

- (instancetype)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider
                   SizeRangeProvider:(id<VZSizeRangeProvider>)sizeProvider;

- (VZFNodeListRecycleState)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context;

- (void)updateState:(const VZFNodeListRecycleState&)state;

- (void)attachToView:(UIView *)view;

- (void)detachFromView;

- (BOOL)isAttachedToView;



@end


@interface UIView(ListRecycleController)

@property(nonatomic,weak)VZFNodeListItemRecycler*  vz_recycler;

@end
