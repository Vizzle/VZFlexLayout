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
#import "VZFScope.h"
#import "VZFlexCell.h"

struct VZFNodeHostingViewInputs{
    VZFRootScope* rootScope;
    id model;
    id context;
    VZFNodeStateUpdateMap stateMap;
    
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
        _pendingInputs = {.rootScope = [VZFRootScope rootScopeWithListener:self]};
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
- (void)nodeStateUpdateDidChanged{

    [self _render];
}
- (void)nodeStateUpdateWithScopeId:(int32_t)scopeId rootScopeId:(int32_t)rootScopeId Func:(id (^)(id))updateFunc{

    _pendingInputs.stateMap.insert({scopeId,updateFunc});
    
    [self _render];
    
}

- (void)_render{

    if (_isRendering) {
        return;
    }
    
    _isRendering = YES;
    _node = [_nodeProvider nodeForItem:_pendingInputs.model context:nil];
    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
    NSLog(@"%@",_node);
    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
    UIView* fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout];
    if (fView) {
        
        [_containerView addSubview:fView];
        
        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
        }
    }

    _isRendering = NO;


}

- (void)renderWithState:(id)state reuseView:(VZFlexCell *)reuseView {
    _node = [_nodeProvider nodeForItem:state context:nil];
    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
    NSLog(@"%s",layout.description().c_str());
    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
    
    UIView* fView;
    
    
    //reuse的时候cell固定有一层hostView和containerView
    if (reuseView.contentView.subviews.count > 0 && reuseView.contentView.subviews[0].subviews.count >0 && reuseView.contentView.subviews[0].subviews[0].subviews.count > 0) {
        double time = [[NSDate date] timeIntervalSince1970];
        fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:reuseView.contentView.subviews[0].subviews[0].subviews[0]];
    
        NSLog(@"render time: %lf ms", [[NSDate date] timeIntervalSince1970] - time);
        
    } else {
        double time = [[NSDate date] timeIntervalSince1970];

        fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:nil];
        NSLog(@"create time: %lf ms", [[NSDate date] timeIntervalSince1970] - time);

    }
    if (fView) {
        
        objc_setAssociatedObject(fView, &kViewReuseInfoKey, _node, OBJC_ASSOCIATION_ASSIGN);
        
        [_containerView addSubview:fView];
        
        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
        }
    }

}



@end
