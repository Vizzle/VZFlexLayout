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

};

struct VZFNodeHostingViewOutputs{
    
    VZFNodeLayout mountedLayout;
    NSSet* mountedNodes;
    VZFNode* mountedNode;
};

@interface VZFNodeHostingView()<VZFStateListener>
{
    Class<VZFNodeProvider> _nodeProvider;
    id<VZSizeRangeProvider> _sizeProvider;;
    VZFNode* _nodeToMount;
    VZFNodeHostingViewInputs _pendingInputs;

    NSSet<VZFNode* >* _mountedNodes;
    VZFNodeLayout _mountedLayout;
    BOOL _isSynchronouslyUpdating;
    BOOL _isAsynchronouslyUpdatingScheduled;
    BOOL _shouldUpdate;
    VZFUpdateMode _updateMode;
}

@end

@implementation VZFNodeHostingView

- (id)initWithFrame:(CGRect)frame{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (id)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider RangeProvider:(id<VZSizeRangeProvider>)sizeProvider{

    self = [super initWithFrame:CGRectZero];
    if (self) {
        _nodeProvider = nodeProvider;
        _sizeProvider = sizeProvider;
        _pendingInputs = {.rootScope = [VZFRootScope rootScopeWithListener:self],
            .stateMap = @{}};

        _shouldUpdate = YES;
        _updateMode = VZFUpdateModeSynchronous;
        
    }
    return self;
}

- (void)dealloc{
    
    //主线程释放.
    [[VZFNodeLayoutManager sharedInstance] unmountNodes:_mountedNodes];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma UIKit

- (void)layoutSubviews{
    
    [super layoutSubviews];
    

    if (!CGRectIsEmpty(self.bounds)) {
        
        //同步更新页面
        [self _updateSynchronously];
        CGSize sz = self.bounds.size;
        if (_mountedLayout.node!= _nodeToMount){
            
            
            CFAbsoluteTime t1 = CFAbsoluteTimeGetCurrent();
            _mountedLayout = [_nodeToMount computeLayoutThatFits:sz];
            CFAbsoluteTime t2 = CFAbsoluteTimeGetCurrent();
            
            NSLog(@"layout计算:%.4f",t2-t1);
    
        }

        
        CFAbsoluteTime t1 = CFAbsoluteTimeGetCurrent();

        _mountedNodes = [[VZFNodeLayoutManager sharedInstance] layoutRootNode:_mountedLayout
                                                                  InContainer:self
                                                            WithPreviousNodes:_mountedNodes
                                                                 AndSuperNode:nil];
        
        CFAbsoluteTime t2 = CFAbsoluteTimeGetCurrent();
        NSLog(@"node 加载:%.4f",t2-t1);
        
        

        
        //resize the container view
//        CGFloat containerWidth  = _mountedLayout.size.width + _mountedLayout.margin.left + _mountedLayout.margin.right;
//        CGFloat containerHeight = _mountedLayout.size.height + _mountedLayout.margin.top + _mountedLayout.margin.bottom;
    
    }
        
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma public API

- (void)update:(id)model mode:(VZFUpdateMode)updateMode{
    
    _pendingInputs.model = model;
    [self _update:updateMode];
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
    [self _update:VZFUpdateModeAsynchronous];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma private methods

- (void)_update:(VZFUpdateMode)mode{
    
//    if (_shouldUpdate && _updateMode == VZFUpdateModeSynchronous) {
//        return;
//    }
    _shouldUpdate = YES;
    _updateMode = mode;
    if (mode == VZFUpdateModeAsynchronous) {
        [self _updateASynchronously];
    }
    else{
        [self setNeedsLayout];
        
        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]){
            [self.delegate hostingViewDidInvalidate:_mountedLayout.size];
        }
    }
}

//同步更新页面
- (void)_updateSynchronously{
    
    if (_shouldUpdate == NO || _updateMode == VZFUpdateModeAsynchronous) {
        return;
    }
    
    if (_isSynchronouslyUpdating) {
        
        VZFAssert(NO, @"理论上同步更新不会有重复更新的问题，这里需要检查下哪里嵌套了-layoutSubviews的调用");
        return ;
    }
    
    _isSynchronouslyUpdating = true;
    
    VZFBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
        return [_nodeProvider nodeForItem:_pendingInputs.model context:nil];
    } RootScope:_pendingInputs.rootScope StateUpdateFuncs:_pendingInputs.stateMap];
    _pendingInputs.rootScope = result.scopeRoot;
    _pendingInputs.stateMap = @{};
    _nodeToMount = result.node;
    _nodeToMount.rootNodeView = self;
    _isSynchronouslyUpdating = false;

}

//异步更新页面
- (void)_updateASynchronously{
    
    if (_updateMode != VZFUpdateModeAsynchronous) {
        _isAsynchronouslyUpdatingScheduled = NO;
        return;
    }
    
    const auto inputs = std::make_shared<const VZFNodeHostingViewInputs>(_pendingInputs);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        VZFBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
            return [_nodeProvider nodeForItem:_pendingInputs.model context:nil];
        } RootScope:_pendingInputs.rootScope StateUpdateFuncs:_pendingInputs.stateMap];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (!_shouldUpdate) {
                return ;
            }
            
            if (_pendingInputs == *inputs) {
                _isAsynchronouslyUpdatingScheduled = NO;
                [self _applyBuildResult:result];
                [self setNeedsLayout];
                if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
                    [self.delegate hostingViewDidInvalidate:_mountedLayout.size];
                }
            }
            else{
                [self _updateASynchronously];
            }
        });
    });
    

}

- (void)_applyBuildResult:(const VZFBuildNodeResult& )result{
    
    _pendingInputs.rootScope = result.scopeRoot;
    _pendingInputs.stateMap = @{};
    _nodeToMount = result.node;
    _shouldUpdate = NO;
    
}

- (void)_update{

//    if (_isRendering) {
//        return;
//    }
//    
//    _isRendering = YES;
//    
//    VZFBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
//        return [_nodeProvider nodeForItem:_pendingInputs.model context:nil];
//    } RootScope:_pendingInputs.rootScope StateUpdateFuncs:_pendingInputs.stateMap];
//    _pendingInputs.rootScope = result.scopeRoot;
//    _pendingInputs.stateMap = @{};
//    _node = result.node;
//    _node.rootNodeView = self;
//    
//    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
//    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
//    NSLog(@"%@",_node);
//    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
//    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
//    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
//    UIView* fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:self->_resultView];
//    
//    //整体View如果是新创建的，则需要移除hostingView上原有的subView
//    if (fView != self->_resultView) {
//        self->_resultView = fView;
//        [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        [_containerView addSubview:fView];
//        
//        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
//            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
//        }
//    }
//    
//    _isRendering = NO;


}

- (id)targetForAction:(SEL)action withSender:(id)sender
{
    return [self respondsToSelector:action] ? self : [[self nextResponder] targetForAction:action withSender:sender];
}

@end
