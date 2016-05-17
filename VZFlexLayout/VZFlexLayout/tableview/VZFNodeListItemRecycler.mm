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
#import "VZFRootScope.h"
#import "VZFNodeProvider.h"
#import "VZFLocker.h"
#import "VZFNodeMemoizer.h"
#import "VZFScopeManager.h"
#import "VZFNodeLayoutManager.h"
#include <objc/runtime.h>


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




@interface VZFNodeListItemRecycler()<VZFStateListener>

@end

@implementation VZFNodeListItemRecycler{

    __weak UIView *_mountedView;
    NSSet *_mountedNodes;
    
    __weak id<VZFNodeProvider> _nodeProvider;
    __weak id<VZSizeRangeProvider> _sizeRangeProvider;
    
    VZ::Mutex _lock; // protects _previousRoot and _pendingStateUpdates
    VZFRootScope *_previousRoot;
    NSDictionary* _stateFuncMap;
    VZFNodeListRecycleState _state;
}

- (instancetype)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider
                   SizeRangeProvider:(id<VZSizeRangeProvider>)sizeProvider
{
    
    self = [super init];
    if (self) {
    
        _nodeProvider       = nodeProvider;
        _sizeRangeProvider  = sizeProvider;
        _stateFuncMap       = @{};
        
        
    }
    return self;

}

- (void)dealloc{

    if (_mountedNodes) {
        
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
    }
}

- (VZFNodeListRecycleState)calculate:(id)item constrainedSize:(CGSize)constrainedSize context:(id<NSObject>)context{

    VZFRootScope* rootScope = _previousRoot?:[VZFRootScope rootScopeWithListener:self];

    VZFNodeMemoizer memoizer(_state.memoizerState);
    
    VZFBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
        return [_nodeProvider nodeForItem:item context:context];
    } RootScope:rootScope StateUpdateFuncs:_stateFuncMap];
    
    
    
    const VZ::NodeLayout layout = [result.node computeLayoutThatFits:constrainedSize];
    
    _previousRoot = result.scopeRoot;
    _stateFuncMap = @{};
    
    return {
        .item = item,
        .context = context,
        .constrainedSize = constrainedSize,
        .layout = layout,
        .memoizerState = memoizer.nextMemoizerState(),
        .rootScope = result.scopeRoot
    };
}

- (void)updateState:(const VZFNodeListRecycleState& )state{
    _state = state;
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


- (void)nodeScopeHandleWithIdentifier:(id)scopeId
                       rootIdentifier:(id)rootScopeId
                didReceiveStateUpdate:(id (^)(id))stateUpdate{
    
    NSMutableDictionary* mutableFuncs = [_stateFuncMap mutableCopy];
    NSMutableArray* funclist = mutableFuncs[scopeId];
    if (!funclist) {
        funclist = [NSMutableArray new];
    }
    [funclist addObject:stateUpdate];
    mutableFuncs[scopeId] = funclist;
    _stateFuncMap = [mutableFuncs copy];
    
    //计算新的size
    CGSize sz = [_sizeRangeProvider rangeSizeForBounds:_state.constrainedSize];
    
    [self _updateStateInternal:[self calculate:_state.item constrainedSize:sz context:_state.context] scopeId:scopeId];
}

- (CGSize)size{

    return _state.layout.size;
}

- (id)item{

    return _state.item;
}

- (VZFRootScope* )scopeRoot{
    
    return _state.rootScope;
}

- (const VZ::NodeLayout& )nodeLayout{

    return _state.layout;
}


- (void)_mountedLayout{
    _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_state.layout InContainer:_mountedView WithPreviousNodes:_mountedNodes AndSuperNode:nil];
    
}


- (void)_updateStateInternal:(const VZFNodeListRecycleState& )state scopeId:(id)scopeId{

    BOOL sizeChanged = !CGSizeEqualToSize(_state.layout.size, state.layout.size);
    
    [self updateState:state];
    
    [self _mountedLayout];
    
    if ([self.delegate respondsToSelector:@selector(nodeStateDidChanged:ShouldInvalidateToNewSize:)]) {
        [self.delegate nodeStateDidChanged:scopeId ShouldInvalidateToNewSize:sizeChanged];
    }
}

@end



