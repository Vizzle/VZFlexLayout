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
    NSObject* object;
    CGSize constrainedSize;
    NodeLayout layout;
    id memoizerState;
    VZFRootScope* rootScope;
    
};

@protocol VZFNodeListRecycleController <NSObject>

@optional
- (void)onNodeStateDidChanged:(const VZFNodeListRecycleState& )state;

@end


/**
 *  列表node的适配器
 */
@interface VZFNodeListRecycleController : NSObject

@property(nonatomic,weak)id<VZFNodeListRecycleController> delegate;
@property(nonatomic,strong) NSIndexPath* indexPath;

- (instancetype)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider
                   SizeRangeProvider:(id<VZSizeRangeProvider>)sizeProvider;

- (VZFNodeListRecycleState)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context;

- (void)updateState:(const VZFNodeListRecycleState&)state;

- (void)attachToView:(UIView *)view;

- (void)detachFromView;

- (BOOL)isAttachedToView;

/** The current top-level layout size for the component */
- (CGSize)size;

/** The last model associated with this lifecycle manager */
- (id)item;

/** The current scope frame associated with this lifecycle manager */
- (VZFRootScope *)scopeRoot;

/** The current component layout associated with this lifecycle manager */
- (const VZ::NodeLayout &)nodeLayout;

@end


@interface UIView(ListRecycleController)

@property(nonatomic,assign)VZFNodeListRecycleController*  vz_recycleController;

@end
