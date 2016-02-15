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

@interface VZFNodeHostingView()
{
    Class<VZFNodeProvider> _nodeProvider;
    id<VZSizeRangeProvider> _sizeProvider;
    UIView* _containerView;
    VZFNode* _node;
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
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_containerView];
            
    }
    return self;
}

- (void)renderWithState:(id)state{

    _node = [_nodeProvider nodeForItem:state context:nil];
    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
    _containerView.frame = {{0,0}, layout.getNodeSize().width, layout.getNodeSize().height};
    UIView* fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout];
    if (fView) {
        [_containerView addSubview:fView];
    }
    
}



@end
