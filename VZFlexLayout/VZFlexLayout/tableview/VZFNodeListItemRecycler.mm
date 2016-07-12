//
//  VZFNodeListAdapter.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeListItemRecycler.h"
#import "VZFSizeRange.h"
#import "VZFNode.h"
#import "VZFNodeSubClass.h"
#import "VZFNodeProvider.h"
#import "VZFNodeLayoutManager.h"
#include <objc/runtime.h>
#import "VZFUtils.h"
#import "VZFMacros.h"


@interface VZFWeakObjectWrapper : NSObject
@property(nonatomic,weak) id object;
@end

@implementation VZFWeakObjectWrapper
@end


const void* g_recycleId = &g_recycleId;
@implementation UIView(ListRecycleController)

- (void)setVz_recycler:(VZFNodeListItemRecycler *)vz_recycler{
    
    VZFWeakObjectWrapper* wrapper = [VZFWeakObjectWrapper new];
    wrapper.object = vz_recycler;
    objc_setAssociatedObject(self, &g_recycleId, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VZFNodeListItemRecycler* )vz_recycler{
    
    VZFWeakObjectWrapper* wrapper = objc_getAssociatedObject(self, g_recycleId);
    return wrapper.object;
}

@end



struct VZItemRecyclerState{
    __strong id props;
    __strong id context;
    CGSize constrainedSize;
    NodeLayout layout;
};
@interface VZFNodeListItemRecycler()

@end

@implementation VZFNodeListItemRecycler{

    __weak UIView *_mountedView;
    NSSet *_mountedNodes;
    
    __weak id<VZFNodeProvider> _nodeProvider;
    VZItemRecyclerState _state;

}

- (CGSize)layoutSize{

    return (CGSize){
        (_state.layout.size.width + _state.layout.margin.left + _state.layout.margin.right),
        (_state.layout.size.height + _state.layout.margin.top + _state.layout.margin.bottom)
    };
}


- (instancetype)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider{
    
    self = [super init];
    if (self) {
    
        _nodeProvider       = nodeProvider;
        _state = {};
    }
    return self;

}

- (void)dealloc{

    if (_mountedNodes) {
        
        for(VZFNode* node in _mountedNodes){
            VZ::Mounting::reset(node.mountedView);
        }
        
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
    }
    if (_mountedView) {
        _mountedView.vz_recycler = nil;
    }
}

- (void)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context{
    
    VZFNode* node = [_nodeProvider nodeForItem:item Store:self.store Context:context];
    
    if (node) {
        const VZ::NodeLayout layout = [node computeLayoutThatFits:constrainedSize];
        _state = {
            .props = item,
            .layout = layout,
            .constrainedSize = constrainedSize,
            .context = context
        };
    }
}

- (void)updateState{

    [self calculate:_state.props constrainedSize:_state.constrainedSize context:_state.context];
    
    //mount layout
    [self _mountedLayout];
}

- (void)attachToView:(UIView *)view{

    if(view.vz_recycler != self){
    
        [self detachFromView];
        [view.vz_recycler detachFromView];
        _mountedView = view;
        view.vz_recycler = self;
        
        NSLog(@"[%@]--->attach:<%ld,%p>",self.class,self.indexPath.row,view);
    }
    
    [self _mountedLayout];
 
}

- (void)detachFromView{
    
    if (_mountedView) {
        
        NSLog(@"[%@]--->detach:<%ld,%p>",self.class, self.indexPath.row, _mountedView);
    
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
        _mountedNodes = nil;
        _mountedView.vz_recycler = nil;
        _mountedView = nil;
    }
}

- (BOOL)isAttachedToView{

    return (_mountedView != nil);
}



- (void)_mountedLayout{
    _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_state.layout
                                                              InContainer:_mountedView
                                                        WithPreviousNodes:_mountedNodes
                                                             AndSuperNode:nil];
    
}



@end



