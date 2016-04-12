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
    if (stacknode)
    {
        stacknode -> _children = VZ::Function::filter(children, [](const VZFStackChildNode &child){return child.node != nil;});
  
        for (const auto  &child:stacknode->_children)
        {
            [stacknode.flexNode addSubNode:child.node.flexNode];
        }
    }
    
    return stacknode;
}

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)constrainedSize{
    
    //只计算一次
    [self.flexNode layout:constrainedSize];
    

    //重写了递归函数@2016/04/11
    std::function<VZFNodeLayout(VZFNode* )> recursiveCalculateNodeLayoutFunc = [&recursiveCalculateNodeLayoutFunc](VZFNode* fNode) -> VZFNodeLayout{
    
    
        //检查是否是CompositeNode
        if ([fNode isKindOfClass:[VZFCompositeNode class]])
        {
            
            VZFCompositeNode* compositeNode = (VZFCompositeNode* )fNode;
            return {
                
                compositeNode,
                compositeNode.flexNode.resultFrame.size,
                compositeNode.flexNode.resultFrame.origin,
                compositeNode.flexNode.resultMargin,
                {
                    {recursiveCalculateNodeLayoutFunc(compositeNode.node)}
                }
                
            };
        }
        else
        {
            if ([fNode isKindOfClass:[VZFStackNode class]])
            {
                
                VZFStackNode* stackNode = (VZFStackNode* )fNode;
                
                if (stackNode.children.size() == 0)
                {
                    
                    return {
                        
                        stackNode,
                        stackNode.flexNode.resultFrame.size,
                        stackNode.flexNode.resultFrame.origin,
                        stackNode.flexNode.resultMargin,{}
                    };
                    
                }else{
                
                    std::vector<VZFNodeLayout> result = {};
                    for (const auto &child : stackNode.children) {
                        
                        VZFNode* childNode = child.node;
                        result.push_back(recursiveCalculateNodeLayoutFunc(childNode));
                    }
                    return {
                        stackNode,
                        stackNode.flexNode.resultFrame.size,
                        stackNode.flexNode.resultFrame.origin,
                        stackNode.flexNode.resultMargin,
                        result
                    
                    };
                    
                }
                
            }
            else
            {
                return {
                    
                    fNode,
                    fNode.flexNode.resultFrame.size,
                    fNode.flexNode.resultFrame.origin,
                    fNode.flexNode.resultMargin,{}
                };
            }
            
        }
    
    };
    
    VZFNodeLayout layout = recursiveCalculateNodeLayoutFunc(self);
    return layout;
}

@end
