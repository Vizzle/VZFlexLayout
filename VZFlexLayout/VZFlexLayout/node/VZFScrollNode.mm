//
//  VZFScrollNode.m
//  O2OReact
//
//  Created by moxin on 16/5/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFScrollNode.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFNodeLayout.h"
#import "VZFCompositeNode.h"
#import "VZFStackNode.h"
#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFNodeViewClass.h"
#import "VZFMacros.h"

@implementation VZFScrollNode

+ (instancetype)newWithScrollAttributes:(const VZ::ScrollNodeSpecs &)scrollSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs Children:(std::vector<VZFNode*>)children{


    VZFScrollNode* scrollNode = [VZFScrollNode newWithView:[UIScrollView class] NodeSpecs:nodeSpecs];
    
    if (scrollNode) {
        
        scrollNode -> _scrollNodeSpecs = scrollSpecs;
        scrollNode -> _children = VZ::Function::filter(children, [](VZFNode* child){return child != nil;});
        
    }
    
    return scrollNode;


}

- (NodeLayout)nodeDidLayout{
    NodeLayout layout = [super nodeDidLayout];
    
    for (const auto &child:self->_children)
    {
        [self.flexNode addSubNode:child.flexNode];
    }
    
    self.flexNode.width = self.scrollNodeSpecs.scrollDirection & VZ::ScrollHorizontal ? FlexLengthAuto : FlexLength{static_cast<float>(layout.size.width),FlexLengthTypeDefault};
    self.flexNode.height = self.scrollNodeSpecs.scrollDirection & VZ::ScrollVertical ? FlexLengthAuto : FlexLength{static_cast<float>(layout.size.height),FlexLengthTypeDefault};
    
    [self.flexNode layout:(CGSize){self.flexNode.width.value, self.flexNode.height.value}];
    
    _contentSize = [super nodeDidLayout].size;
    
    for (const auto &child : _children) {
        layout.children->push_back([child nodeDidLayout]);
    }
    
    return layout;
}

@end
