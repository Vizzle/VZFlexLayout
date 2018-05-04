//
//  VZFPagingNode.m
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFPagingNode.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFNodeLayout.h"
#import "VZFCompositeNode.h"
#import "VZFStackNode.h"
#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFNodeViewClass.h"
#import "VZFMacros.h"
#import "VZFNodeSpecs.h"
#import "VZFPagingView.h"

@implementation VZFPagingNode

+ (instancetype)newWithPagingAttributes:(const VZ::PagingNodeSpecs &)pagingSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs Children:(std::vector<VZFNode*>)children{
    
    VZFPagingNode* pagingNode = [VZFPagingNode newWithView:[VZFPagingView class] NodeSpecs:nodeSpecs];
    
    if (pagingNode) {
        
        pagingNode -> _pagingNodeSpecs = pagingSpecs;
        pagingNode -> _children = VZ::Function::filter(children, [](VZFNode* child){return child != nil;});

        if (pagingSpecs.pageControl) {
            pagingNode -> _pageControlNode = [VZFNode newWithView:[UIPageControl class] NodeSpecs:{

                .fixed = true,
                .height = 7 * pagingSpecs.pageControlScale,
                .width = (7 * pagingNode->_children.size() + 9 * MAX(0, pagingNode->_children.size() - 1)) * pagingSpecs.pageControlScale,
                .marginLeft = pagingSpecs.pageControlMarginLeft,
                .marginRight = pagingSpecs.pageControlMarginRight,
                .marginTop = pagingSpecs.pageControlMarginTop,
                .marginBottom = pagingSpecs.pageControlMarginBottom,

            }];
        }
        
    }
    
    return pagingNode;
}

- (NodeLayout)nodeDidLayout{
    NodeLayout layout = [super nodeDidLayout];
    
    self.flexNode.width = FlexLength{(float)layout.size.width,FlexLengthTypePoint};
    self.flexNode.height = FlexLength{(float)layout.size.height,FlexLengthTypePoint};
    
    for (const auto &child : _children) {
        [child.flexNode layout:layout.size];
        NodeLayout childLayout = [child nodeDidLayout];
        _childrenLayout.push_back(childLayout);
//        layout.children->push_back(childLayout);
    }
    
    if (_pageControlNode) {
        [self.flexNode addSubNode:_pageControlNode.flexNode];
        [self.flexNode layout:layout.size];
    }
    
    return layout;
}

- (void)willUnmount {
    if ([self.mountedView isKindOfClass:[VZFPagingView class]]) {
//        [(VZFPagingView *)self.mountedView setChildrenViews:nil];
        ((VZFPagingView *)self.mountedView).autoScroll = 0;
    }
    [super willUnmount];
}

@end
