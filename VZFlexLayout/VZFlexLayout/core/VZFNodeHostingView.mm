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

@interface VZFNodeHostingView()<VZFStateListener>
{
    Class<VZFNodeProvider> _nodeProvider;
    id<VZSizeRangeProvider> _sizeProvider;
    UIView* _containerView;
    VZFNode* _node;
    VZFNodeHostingViewInputs _pendingInputs;
    BOOL _isRendering;
    UIView* _resultView;
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
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
//        _containerView.backgroundColor = [UIColor c];
        [self addSubview:_containerView];
            
    }
    return self;
}

- (void)render:(id)model{

    _pendingInputs.model = model;

    [self _render];
}
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
    [self _render];
}

- (void)_render{

    if (_isRendering) {
        return;
    }
    
    _isRendering = YES;
    
    VZBuildNodeResult result = [VZFScopeManager buildNodeWithFunction:^VZFNode *{
        return [_nodeProvider nodeForItem:_pendingInputs.model context:nil];
    } RootScope:_pendingInputs.rootScope StateUpdateFuncs:_pendingInputs.stateMap];
    _pendingInputs.rootScope = result.scopeRoot;
    _pendingInputs.stateMap = @{};
    _node = result.node;
    _node.hostingView = self;
    
    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
    NSLog(@"%@",_node);
    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
    UIView* fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:self->_resultView];
    
    //整体View如果是新创建的，则需要移除hostingView上原有的subView
    if (fView != self->_resultView) {
        self->_resultView = fView;
        [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_containerView addSubview:fView];
        
        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
        }
    }
    
    _isRendering = NO;


}

//- (void)renderWithState:(id)state reuseView:(VZFlexCell *)reuseView {
//    _node = [_nodeProvider nodeForItem:state context:nil];
//    _node.hostingView = self;
//    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
//    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
//    NSLog(@"%s",layout.description().c_str());
//    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
//    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
//    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
//    
//    UIView* fView;
//    
//    
//    //reuse的时候cell固定有一层hostView和containerView
//    if (reuseView.contentView.subviews.count > 0 && reuseView.contentView.subviews[0].subviews.count >0 && reuseView.contentView.subviews[0].subviews[0].subviews.count > 0) {
//        double time = [[NSDate date] timeIntervalSince1970];
//        fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:reuseView.contentView.subviews[0].subviews[0].subviews[0]];
//    
//        NSLog(@"render time: %lf ms", [[NSDate date] timeIntervalSince1970] - time);
//        
//    } else {
//        double time = [[NSDate date] timeIntervalSince1970];
//
//        fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:nil];
//        NSLog(@"create time: %lf ms", [[NSDate date] timeIntervalSince1970] - time);
//
//    }
//    if (fView) {
//        
//        objc_setAssociatedObject(fView, &kViewReuseKey, _node, OBJC_ASSOCIATION_ASSIGN);
//        
//        [_containerView addSubview:fView];
//        
//        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
//            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
//        }
//    }
//
//}

- (id)targetForAction:(SEL)action withSender:(id)sender
{
    return [self respondsToSelector:action] ? self : [[self nextResponder] targetForAction:action withSender:sender];
}

@end
