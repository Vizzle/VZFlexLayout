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
#import "VZFMacros.h"
#import "VZFCompositeNode.h"

@interface VZFStackNode()

@end

@implementation VZFStackNode
{

}

@synthesize children = _children;
@synthesize specs = _specs;
@synthesize flexNode = _flexNode;

- (NodeSpecs)specs{
    return _specs;
}

- (std::vector<VZFStackChildNode>)children{
    return _children;
}

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)nodeWithStackSpecs:(const NodeSpecs& )specs Children:(const std::vector<VZFStackChildNode> &)children{

    VZFStackNode* stacknode =  [super newWithView:[UIView class] NodeSpecs:specs];
    if (stacknode) {
        
        stacknode -> _specs             = specs;
        stacknode -> _children          = VZ::F::filter(children, [](const VZFStackChildNode &child){return child.node != nil;});
        stacknode -> _flexNode          = [VZFNodeUISpecs flexNodeWithAttributes:specs.flex];
        stacknode -> _flexNode.name     = [[NSString alloc]initWithUTF8String:specs.name.c_str()];
        
        for (const auto  &child:stacknode->_children)
        {
            [stacknode -> _flexNode addSubNode:child.node.flexNode];
        }
        
    }
    
    return stacknode;
}

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)constrainedSize{
    
    [_flexNode layout:constrainedSize];
    
    //递归
    std::function<VZFNodeLayout(VZFlexNode* )> lambda = [&lambda](VZFlexNode* node)->VZFNodeLayout{
    
        if (node.childNodes.count == 0) {
            return {node.resultFrame.size,node.resultFrame.origin,node.resultMargin,{}};
        }
        else{
            
            std::vector<VZFNodeLayout> childlayouts = {};
            for(VZFlexNode* child in node.childNodes){
                childlayouts.push_back(lambda(child));
            }
            return {node.resultFrame.size,node.resultFrame.origin,node.resultMargin,childlayouts};
        }
    };
    VZFNodeLayout layout = lambda(_flexNode);
    
    return layout;
}

@end
