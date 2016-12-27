//
//  VZFStackNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFStackNode.h"
#import "VZFlexNode.h"
#import "VZFlexNode+VZFNode.h"
#import "VZFUtils.h"
#import "VZFNodeInternal.h"
#import "VZFMacros.h"
#import "VZFCompositeNode.h"
#import "VZFNodeLayout.h"
#import "VZFNodeViewClass.h"
#import "VZFStackView.h"

using namespace VZ;
@implementation VZFStackNode
{

}

@synthesize children = _children;

- (std::vector<VZFStackChildNode>)children{
    return _children;
}

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)newWithStackAttributes:(const StackNodeSpecs& )stackSpecs
                             NodeSpecs:(const NodeSpecs& )specs
                              Children:(const std::vector<VZFStackChildNode> &)children{

    VZFStackNode* stacknode =  [super newWithView:[VZFStackView class] NodeSpecs:specs];
    if (stacknode)
    {
        stacknode -> _stackSpecs    = stackSpecs;
        stacknode -> _children      = VZ::Function::filter(children, [](const VZFStackChildNode &child){return child.node != nil;});
        
        //apply container attributes
        [stacknode.flexNode applyStackLayoutAttributes:stackSpecs];
        
        for (const auto  &child:stacknode->_children)
        {
            [stacknode.flexNode addSubNode:child.node.flexNode];
        }
    }
    
    return stacknode;

}

- (VZ::NodeLayout)nodeDidLayout {
    
    VZ::NodeLayout layout = [super nodeDidLayout];
    for (const auto &child : _children) {
        layout.children->push_back([child.node nodeDidLayout]);
    }
    
    return layout;
}

- (NodeLayout)computeLayoutThatFits:(CGSize)constrainedSize{
    
    //只计算一次
    [self.flexNode layout:constrainedSize];
    return [self nodeDidLayout];
}

- (BOOL)shouldRender {
    return NO;
}

@end
