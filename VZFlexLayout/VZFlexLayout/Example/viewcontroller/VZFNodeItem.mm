//
//  VZFNodeItem.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeItem.h"
#import "VZFNodeListRecycleController.h"
#import "VZFSizeRange.h"
#import "VZFNodeProvider.h"
#import "FBHostNode.h"
#import "VZFNodeSpecs.h"
#import "FBContentNode.h"

@interface VZFNodeItem()<VZFNodeProvider,VZFNodeListRecycleController>
{
    VZFNodeListRecycleState _recycleState;
}
@property(nonatomic,strong) VZFNodeListRecycleController* nodeRecycleController;
@end

@implementation VZFNodeItem

- (float)height{
    return _recycleState.layout.size.height + _recycleState.layout.margin.top + _recycleState.layout.margin.bottom;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        _nodeRecycleController = [[VZFNodeListRecycleController alloc]initWithNodeProvider:self
                                                                         SizeRangeProvider:[VZSizeRangeProvider defaultRangeProvider:VZFlexibleSizeHeight]];
        _nodeRecycleController.delegate = self;
        
    }
    return self;
}


- (void)setModel:(id)model{
    _model = model;
    //计算高度
    _recycleState = [_nodeRecycleController calculate:model constrainedSize:{self.constrainedWidth,VZ::FlexValue::Auto} context:nil];
    [_nodeRecycleController updateState:_recycleState];

}

- (void)attachToView:(UIView* )view{
    
    [_nodeRecycleController attachToView:view];

}
- (void)detach{

    [_nodeRecycleController detachFromView];
}


- (VZFNode* )nodeForItem:(FBHostItem* )item context:(id<NSObject>)context{

    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    return [FBContentNode newWithItem:item];
//    return [FBHostNode newWithItem:item];

}

- (void)onNodeStateDidChanged:(const VZFNodeListRecycleState& )state{

    CGSize newSize = state.layout.size;
    _recycleState = state;
    
    [self.delegate onItemSizeChanged:newSize Index:self.indexPath];
    


}

@end
