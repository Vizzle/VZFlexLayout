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


@implementation VZFStackNode
{

}

@synthesize children = _children;

- (std::vector<VZFStackChildNode>)children{
    return _children;
}

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)newWithStackSpecs:(const NodeSpecs& )specs Children:(const std::vector<VZFStackChildNode> &)children{

    VZFStackNode* stacknode =  [super newWithView:[UIView class] NodeSpecs:specs];
    if (stacknode) {
        stacknode -> _children = VZ::Function::filter(children, [](const VZFStackChildNode &child){return child.node != nil;});
  
        for (const auto  &child:stacknode->_children)
        {
            [child.node addToParentNode:stacknode];
            [stacknode.flexNode addSubNode:child.node.flexNode];
        }
        
    }
    
    return stacknode;
}

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)constrainedSize{
    
    //caclculate the frame
    [self.flexNode layout:constrainedSize];
    
    //递归
    std::function<VZFNodeLayout(VZFlexNode* )> lambda = [&lambda](VZFlexNode* flexNode)->VZFNodeLayout{
    
        if (flexNode.childNodes.count == 0) {
            return {
                flexNode.fNode,
                flexNode.resultFrame.size,
                flexNode.resultFrame.origin,
                flexNode.resultMargin,{}};
        }
        else{
            
            std::vector<VZFNodeLayout> childlayouts = {};
            for(VZFlexNode* child in flexNode.childNodes){
                childlayouts.push_back(lambda(child));
            }
            return {flexNode.fNode,flexNode.resultFrame.size,flexNode.resultFrame.origin,flexNode.resultMargin,childlayouts};
        }
    };
    
    VZFNodeLayout layout = lambda(self.flexNode);
    return layout;
}

@end
