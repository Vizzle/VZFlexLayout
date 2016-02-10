//
//  VZFStackNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFStackNode.h"
#import "VZFlexNode.h"
#import "VZFUtils.h"
#import "VZFNodeInternal.h"
#import "VZFNodeSubclass.h"
#import "VZFMacros.h"

@interface VZFStackNode()

//@property(nonatomic,strong)VZFlexNode* flexNode;

@end

@implementation VZFStackNode
{
    VZFStackLayout _layout;
    std::vector<VZFStackChildNode> _children;
}

@synthesize flexNode = _flexNode;


+ (instancetype)nodeWithUISpecs:(const VZ::UISpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)nodeWithStackLayout:(const VZFStackLayout& )layout Children:(const std::vector<VZFStackChildNode> &)children
{
    //create an empty node
    VZFStackNode* stacknode =  [super nodeWithUISpecs:{}];
    if (stacknode) {
        
        stacknode -> _layout = layout;
        stacknode -> _children = children;
        stacknode -> _flexNode                = [VZFlexNode new];
        stacknode -> _flexNode.name           = @"stackNode";
        stacknode -> _flexNode.flexDirection  = (VZFlexNodeDirection)layout.direction;
        stacknode -> _flexNode.justifyContent = (VZFlexNodeJustifyContent)layout.justifyContent;
        stacknode -> _flexNode.alignItems     = (VZFlexNodeAlignItems)layout.alignItems;
        stacknode -> _flexNode.size           = {layout.flexAttributes.width,layout.flexAttributes.height};
        stacknode -> _flexNode.margin         = {layout.flexAttributes.marginTop,
                                                 layout.flexAttributes.marginLeft,
                                                 layout.flexAttributes.marginBottom,
                                                 layout.flexAttributes.marginRight};
        
        
        stacknode -> _children = VZ::F::filter(children, [](const VZFStackChildNode &child){
            return child.node != nil;
        });
        for (auto &child:stacknode->_children) {
            [stacknode -> _flexNode addSubNode:child.node.flexNode];
        }

    }

    return stacknode;
}

- (void)prepareForLayout{

    
}
- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];

    
    std::vector<VZ::NodeLayout> childrenLayouts{};
    for (VZFStackChildNode child : _children) {
    
        VZFNodeLayout l = [child.node computeLayoutThatFits:sz];
        childrenLayouts.push_back(l);
    }
    
    VZFNodeLayout layout = { _flexNode.frame.size, _flexNode.frame.origin, childrenLayouts};
    return layout;
}




@end
