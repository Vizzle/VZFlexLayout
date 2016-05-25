//
//  VZFNodeHostingView.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeHostingView.h"
#import "VZFNodeViewManager.h"
#import "VZFMacros.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFRootScope.h"
#import "VZFScopeManager.h"
#import "VZFNodeLayout.h"
#import "VZFNodeLayoutManager.h"
#import "VZFUtils.h"
#import "VZFNodeSubClass.h"

using namespace VZ;

struct VZFNodeHostingViewInputs{
    VZFRootScope* rootScope;
    id model;
    id context;
    NSDictionary* stateMap;
    
    bool operator==(const VZFNodeHostingViewInputs &i) const {
        return rootScope == i.rootScope &&
        model == i.model &&
        context == i.context &&
        stateMap == i.stateMap;
    };
    
    void clear(){
        rootScope = nil;
        model = nil;
        context = nil;
        stateMap = nil;
    }

};


@interface VZFNodeHostingView()<VZFStateListener>
{
    __weak id<VZFNodeProvider> _nodeProvider;
    __weak id<VZSizeRangeProvider> _sizeProvider;;
    VZFNodeHostingViewInputs _pendingInputs;

    NSSet<VZFNode* >* _mountedNodes;
    NodeLayout _mountedLayout;
    BOOL _isUpdating;
    VZFUpdateMode _updateMode;
    dispatch_queue_t _serialQueue;
}

@end

@implementation VZFNodeHostingView

- (id)initWithFrame:(CGRect)frame{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (id)initWithNodeProvider:(id<VZFNodeProvider>)nodeProvider RangeProvider:(id<VZSizeRangeProvider>)sizeProvider{

    self = [super initWithFrame:CGRectZero];
    if (self) {
        _nodeProvider = nodeProvider;
        _sizeProvider = sizeProvider;
        _pendingInputs = {.rootScope = [VZFRootScope rootScopeWithListener:self],
            .stateMap = @{}};
        
        _serialQueue = dispatch_queue_create("com.fnode.hostingview", DISPATCH_QUEUE_SERIAL);
        _updateMode = VZFUpdateModeSynchronous;
        
    }
    return self;
}

- (void)dealloc{
    
    
    NSLog(@"[%@]-->dealloc",self.class);
    
    //主线程释放.
    [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
//    [[VZFScopeManager sharedInstance] releaseRootScopeById:_pendingInputs.rootScope.rootScopeId];
    _pendingInputs.clear();
    
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma public API

- (void)update:(id)model mode:(VZFUpdateMode)updateMode{
    _pendingInputs.model = model;
    [self _update:updateMode];

}

- (void)reset{

    if (_mountedNodes) {
        
        for(VZFNode* node in _mountedNodes){
            VZ::Mounting::reset(node.mountedView);
        }
        [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma state callback
- (void)nodeScopeHandleWithIdentifier:(id)scopeId
                       rootIdentifier:(id)rootScopeId
                didReceiveStateUpdate:(id (^)(id))stateUpdate{

    NSMutableDictionary* mutableFuncs = [_pendingInputs.stateMap mutableCopy];
    NSMutableArray* funclist = mutableFuncs[scopeId];
    if (!funclist) {
        funclist = [NSMutableArray new];
    }
    [funclist addObject:stateUpdate];
    mutableFuncs[scopeId] = funclist;
    _pendingInputs.stateMap = [mutableFuncs copy];
    [self _update:VZFUpdateModeSynchronous];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma private methods

- (void)_update:(VZFUpdateMode)mode{
    
    _updateMode = mode;
    if (mode == VZFUpdateModeAsynchronous) {
        [self _updateASynchronously];
    }
    else{
        [self _updateSynchronously];
    }
}


//同步更新页面
- (void)_updateSynchronously{
    
    
    if (!_pendingInputs.model) {
        return;
    }
    
    if (_isUpdating) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _updateSynchronously];
        });
    }
    
    _isUpdating = true;
    
    NSUInteger tag = self.tag;
    VZFBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
        return [_nodeProvider nodeForItem:_pendingInputs.model context:@(tag)];
    } RootScope:_pendingInputs.rootScope StateUpdateFuncs:_pendingInputs.stateMap];
    _pendingInputs.rootScope = result.scopeRoot;
    _pendingInputs.stateMap = @{};
    
    
    //container size
    CGSize sz = [_sizeProvider rangeSizeForBounds:self.bounds.size];
        
    CFAbsoluteTime t1 = CFAbsoluteTimeGetCurrent();
    _mountedLayout = [result.node computeLayoutThatFits:sz];
    CFAbsoluteTime t2 = CFAbsoluteTimeGetCurrent();
        
    NSLog(@"[%@]-->layout:%.3f ms",self.class,(t2-t1)*1000);
        
        //mount nodes
    _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_mountedLayout
                                                                  InContainer:self
                                                            WithPreviousNodes:_mountedNodes
                                                                 AndSuperNode:nil];
        
        
    if ([self.delegate respondsToSelector:@selector(hostingView:DidInvalidate:)]) {
        [self.delegate hostingView:self DidInvalidate:[self containerSizeForHostingView:_mountedLayout]];
    }
    
    _isUpdating = false;

}

//异步更新页面
- (void)_updateASynchronously{
    
    if (!_pendingInputs.model) {
        return;
    }
    NSUInteger tag = self.tag;
    dispatch_async(_serialQueue, ^{
       
        VZFBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
            return [_nodeProvider nodeForItem:_pendingInputs.model context:@(tag)];
        } RootScope:_pendingInputs.rootScope StateUpdateFuncs:_pendingInputs.stateMap];
        
        
        CGSize sz = [_sizeProvider rangeSizeForBounds:self.bounds.size];
        
        CFAbsoluteTime t1 = CFAbsoluteTimeGetCurrent();
        _mountedLayout = [result.node computeLayoutThatFits:sz];
        CFAbsoluteTime t2 = CFAbsoluteTimeGetCurrent();
        
        NSLog(@"[%@]-->layout:%.3f ms",self.class,(t2-t1)*1000);

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_mountedLayout
                                                                      InContainer:self
                                                                WithPreviousNodes:_mountedNodes
                                                                     AndSuperNode:nil];
            
            
            if ([self.delegate respondsToSelector:@selector(hostingView:DidInvalidate:)]) {
                [self.delegate hostingView:self DidInvalidate:[self containerSizeForHostingView:_mountedLayout]];
            }
        });
    });
    

}


- (CGSize)containerSizeForHostingView:(const NodeLayout& )layout
{
    CGFloat containerWidth  = layout.size.width + layout.margin.left + layout.margin.right;
    CGFloat containerHeight = layout.size.height + layout.margin.top + layout.margin.bottom;
    return {containerWidth,containerHeight};
}

- (id)targetForAction:(SEL)action withSender:(id)sender
{
    return [self respondsToSelector:action] ? self : [[self nextResponder] targetForAction:action withSender:sender];
}

@end
