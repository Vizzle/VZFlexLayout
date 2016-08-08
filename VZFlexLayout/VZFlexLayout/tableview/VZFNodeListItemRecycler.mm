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
#import "VZFluxStore.h"
#import "VZFNodeInternal.h"

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
    
    __weak Class<VZFNodeProvider> _nodeProvider;
    VZItemRecyclerState _state;

}


- (CGSize)layoutSize{

    return (CGSize){
        (_state.layout.size.width + _state.layout.margin.left + _state.layout.margin.right),
        (_state.layout.size.height + _state.layout.margin.top + _state.layout.margin.bottom)
    };
}


- (instancetype)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider{
    
    self = [super init];
    if (self) {
    
        _nodeProvider = nodeProvider;
        _state        = {};
    }
    return self;

}

- (void)dealloc{

    [self reset];
    
    if (_mountedView) {
        _mountedView.vz_recycler = nil;
    }
}

- (void)reset{

    if (_mountedNodes) {
        
        for(VZFNode* node in _mountedNodes){
            VZ::Mounting::reset(node.mountedView);
        }
        
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
    }
}

- (void)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context{
    
    VZFNode* node = [_nodeProvider nodeForItem:item Store:_store Context:context];
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

    [self calculate:_state.props
    constrainedSize:_state.constrainedSize
            context:_state.context];
    
    //mount layout
    //[self _mount];
}

- (void)attachToView:(UIView *)view {
    [self attachToView:view asyncDisplay:NO];
}

//为了替换这个方法 单独抽离出来
-(BOOL)asyncDisplayLogic:(BOOL)asyncDisplay{
    return asyncDisplay;
}

- (void)attachToView:(UIView *)view asyncDisplay:(BOOL)asyncDisplay {

    if(view.vz_recycler != self){
    
        [self detachFromView];
        [view.vz_recycler detachFromView];
        _mountedView = view;
        view.vz_recycler = self;
        
//        NSLog(@"[%@]--->attach:<%ld,%p>",self.class,self.indexPath.row,view);
    }
    
    [self _mount];
 
}
-(void)cleanVZFNodeView:(UIView *)v{
    NSArray *subView = [v.subviews copy];
    for (UIView *v in subView) {
        NSString *className = [NSString stringWithUTF8String:class_getName([v class])];
        if (![@"_VZAView" isEqualToString:className]){
            [v removeFromSuperview];
        }
    }
}

- (void)detachFromView{
    
    if (_mountedView) {
        
//        NSLog(@"[%@]--->detach:<%ld,%p>",self.class, self.indexPath.row, _mountedView);
    
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
        _mountedNodes = nil;
        _mountedView.vz_recycler = nil;
        _mountedView = nil;
    }
}

- (BOOL)isAttachedToView{
    return (_mountedView != nil);
}



- (void)_mount{
    _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_state.layout
                                                              InContainer:_mountedView
                                                        WithPreviousNodes:_mountedNodes
                                                             AndSuperNode:nil];
    
}



@end



