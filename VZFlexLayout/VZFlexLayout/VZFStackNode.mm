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
        
        stacknode -> _layout            = layout;
        stacknode -> _children          = VZ::F::filter(children, [](const VZFStackChildNode &child){return child.node != nil;});
        stacknode -> _flexNode          = [VZFlexNode new];
        stacknode -> _flexNode.name     = @"stackNode";

        [stacknode applyFlexAttributes:layout.flex];
        
        for (auto &child:stacknode->_children) {
            [stacknode -> _flexNode addSubNode:child.node.flexNode];
        }

    }

    return stacknode;
}

- (void)prepareForLayout{

    
}
- (VZFNodeLayout)computeLayoutThatFits:(CGSize)constrainedSize{
    
    [_flexNode layout:constrainedSize];
    
    //递归
    std::function<VZFNodeLayout(VZFlexNode* )> lambda = [&lambda](VZFlexNode* node)->VZFNodeLayout{
    
        if (node.childNodes.count == 0) {
            return {node.frame.size,node.frame.origin,{}};
        }
        else{
            
            std::vector<VZFNodeLayout> childlayouts = {};
            for(VZFlexNode* child in node.childNodes){
                childlayouts.push_back(lambda(child));
            }
            return {node.frame.size,node.frame.origin,childlayouts};
        }
    };
    VZFNodeLayout layout = lambda(_flexNode);
    
    return layout;
}


- (void)applyFlexAttributes:(const VZ::FlexAttrs &)flexAttributes{
    
    [super applyFlexAttributes:flexAttributes];
    
    FlexDirection direction = FlexHorizontal;
    if (_layout.direction == VZFStackLayoutDirectionVertical) {
        direction = FlexVertical;
    }
    
    FlexAlign justifyContent = FlexInherit;
    if (_layout.justifyContent == VZFStackLayoutJustifyContentStart) {
        justifyContent = FlexStart;
    }
    else if (_layout.justifyContent == VZFStackLayoutJustifyContentCenter){
        justifyContent = FlexCenter;
    }
    else if (_layout.justifyContent == VZFStackLayoutJustifyContentEnd){
        justifyContent = FlexEnd;
    }
    else if (_layout.justifyContent == VZFStackLayoutJustifyContentSpaceBetween){
        justifyContent = FlexSpaceBetween;
    }

    FlexAlign alignItems = FlexInherit;
    if (_layout.alignItems == VZFStackLayoutAlignItemsStart) {
        alignItems = FlexStart;
    }
    else if (_layout.alignItems == VZFStackLayoutAlignItemsCenter) {
        alignItems = FlexCenter;
    }
    else if (_layout.alignItems == VZFStackLayoutAlignItemsEnd) {
        alignItems = FlexEnd;
    }
    else if (_layout.alignItems == VZFStackLayoutAlignItemsStretch){
        alignItems = FlexStretch;
    }
    
    _flexNode.direction = direction;
    _flexNode.alignItems = alignItems;
    _flexNode.justifyContent = justifyContent;


}

@end
