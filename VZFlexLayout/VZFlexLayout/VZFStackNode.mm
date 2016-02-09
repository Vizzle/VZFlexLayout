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
#import "VZFNodeSubclass.h"

@implementation VZFStackNode
{
    VZFStackLayout _layout;
    VZFlexNode*  _flexNode; //this will shadow the parent node
    std::vector<VZFStackChildNode> _children;
}

+ (instancetype)nodeWithStackLayout:(const VZFStackLayout& )layout Children:(const std::vector<VZFStackChildNode> &)children
{
    //create an empty node
    VZFStackNode* stacknode = [[self alloc] init];
    
    if (stacknode) {
        
        stacknode -> _layout = layout;
        stacknode -> _children = children;
    }

    return stacknode;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        _flexNode = [VZFlexNode new];
        _flexNode.flexDirection     = (VZFlexNodeDirection)_layout.direction;
        _flexNode.justifyContent    = (VZFlexNodeJustifyContent)_layout.justifyContent;
        _flexNode.alignItems        = (VZFlexNodeAlignItems)_layout.alignItems;
        _flexNode.size              = {_layout.flexAttributes.width,_layout.flexAttributes.height};
        _flexNode.margin            = UIEdgeInsetsMake(_layout.flexAttributes.marginTop,
                                                   _layout.flexAttributes.marginLeft,
                                                   _layout.flexAttributes.marginBottom,
                                                   _layout.flexAttributes.marginRight);
        
    }
    return self;
}

- (void)prepareForLayout{

    
}
- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];

    
    std::vector<VZ::NodeLayout> childrenLayouts{};
    
    //过滤掉node为空的
    std::vector<VZFStackChildNode> children = VZ::F::filter(_children, [](const VZFStackChildNode &child){
        return child.node != nil;
    });
    
    for (VZFStackChildNode child : children) {
        VZFNodeLayout l = [child.node computeLayoutThatFits:sz];
        childrenLayouts.push_back(l);
    }
    
    VZFNodeLayout layout = {
        
        .origin     = _flexNode.frame.origin,
        .size       = _flexNode.frame.size,
        .margin     = UIEdgeInsetsZero,
        .children   =  std::make_shared<std::vector<VZ::NodeLayout>>(childrenLayouts)
    };


    return layout;
}




@end
