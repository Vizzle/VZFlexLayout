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
{
    CGSize _containerSize;
    
}

+ (instancetype)newWithScrollAttributes:(const VZ::ScrollNodeSpecs &)scrollSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs Children:(std::vector<VZFScrollChildNode>)children{


    VZFScrollNode* scrollNode = [VZFScrollNode newWithView:[UIScrollView class] NodeSpecs:nodeSpecs];
    
    if (scrollNode) {
        
        scrollNode -> _scrollNodeSpecs = scrollSpecs;
        scrollNode -> _children = VZ::Function::filter(children, [](const VZFScrollChildNode &child){return child.node != nil;});
        
        scrollNode.flexNode.direction   = scrollSpecs.direction == VZ::ScrollDirection::Horizontal?FlexHorizontal:FlexVertical;
        scrollNode.flexNode.spacing = FlexLength{scrollSpecs.spacing,FlexLengthTypeDefault};
        
    }
    
    return scrollNode;


}

- (NodeLayout)nodeDidLayout:(const VZ::NodeLayout &)layout{

    
    for (const auto  &child:self->_children)
    {
        [self.flexNode addSubNode:child.node.flexNode];
    }
    
    if (self.scrollNodeSpecs.direction == VZ::ScrollDirection::Vertical) {
        self.flexNode.width = FlexLength{static_cast<float>(layout.size.width),FlexLengthTypeDefault};
        self.flexNode.height = FlexLengthAuto;
    }
    else{
        self.flexNode.width = FlexLengthAuto;
        self.flexNode.height = FlexLength{(float)layout.size.height,FlexLengthTypeDefault};
    }
    [self.flexNode layout:(CGSize){self.flexNode.width.value, self.flexNode.height.value}];
    
    std::function<NodeLayout(VZFNode* )> recursiveCalculateNodeLayoutFunc = [&recursiveCalculateNodeLayoutFunc](VZFNode* fNode) -> NodeLayout{
        
        
        //检查是否是CompositeNode
        if ([fNode isKindOfClass:[VZFCompositeNode class]])
        {
            
            VZFCompositeNode* compositeNode = (VZFCompositeNode* )fNode;
            NodeLayout layout =  {
                
                compositeNode,
                compositeNode.flexNode.resultFrame.size,
                compositeNode.flexNode.resultFrame.origin,
                compositeNode.flexNode.resultMargin,
                {
                    {recursiveCalculateNodeLayoutFunc(compositeNode.node)}
                }
                
            };
            return [compositeNode nodeDidLayout:layout];
        }
        else if( [fNode isKindOfClass:[VZFStackNode class]]){
            
            VZFStackNode* stackNode = (VZFStackNode* )fNode;
            
            if (stackNode.children.size() == 0)
            {
                
                NodeLayout layout =  {
                    
                    stackNode,
                    stackNode.flexNode.resultFrame.size,
                    stackNode.flexNode.resultFrame.origin,
                    stackNode.flexNode.resultMargin,{}
                };
                return [stackNode nodeDidLayout:layout];
                
            }else{
                
                std::vector<NodeLayout> result = {};
                for (const auto &child : stackNode.children) {
                    
                    VZFNode* childNode = child.node;
                    result.push_back(recursiveCalculateNodeLayoutFunc(childNode));
                }
                NodeLayout layout = {
                    stackNode,
                    stackNode.flexNode.resultFrame.size,
                    stackNode.flexNode.resultFrame.origin,
                    stackNode.flexNode.resultMargin,
                    result
                    
                };
                
                return [stackNode nodeDidLayout:layout];
            }
        }
        else
        {
            if ( [fNode isKindOfClass:[VZFScrollNode class]])
            {
                
                VZFScrollNode* stackNode = (VZFScrollNode* )fNode;
                
                if (stackNode.children.size() == 0)
                {
                    
                    return {
                        
                        stackNode,
                        stackNode.flexNode.resultFrame.size,
                        stackNode.flexNode.resultFrame.origin,
                        stackNode.flexNode.resultMargin,{}
                    };
                    
                    //do not nofity
                    
                }else{
                    
                    std::vector<NodeLayout> result = {};
                    for (const auto &child : stackNode.children) {
                        
                        VZFNode* childNode = child.node;
                        VZFCAssert(![childNode isKindOfClass:[VZFScrollNode class]], @"不支持scrollnode的嵌套");
                        result.push_back(recursiveCalculateNodeLayoutFunc(childNode));
                    }
                    return {
                        stackNode,
                        stackNode.flexNode.resultFrame.size,
                        stackNode.flexNode.resultFrame.origin,
                        stackNode.flexNode.resultMargin,
                        result
                        
                    };
                    
                    //do not notify
                    
                }
                
            }
            else
            {
                NodeLayout layout = {
                    
                    fNode,
                    fNode.flexNode.resultFrame.size,
                    fNode.flexNode.resultFrame.origin,
                    fNode.flexNode.resultMargin,{}
                };
                
                //notify children
                return [fNode nodeDidLayout:layout];
            }
            
        }
        
    };
    
    NodeLayout result = recursiveCalculateNodeLayoutFunc(self);
    //scrollview自己的size
    NSLog(@"%@",[NSString stringWithUTF8String:layout.description().c_str()]);
    
    _containerSize = result.size;
    result.origin = CGPointMake(layout.origin.x, layout.origin.y);
    result.size = CGSizeMake(layout.size.width, layout.size.height);
    result.margin = UIEdgeInsetsMake(layout.margin.top, layout.margin.left, layout.margin.bottom, layout.margin.right); 
    
    
    return result;

}

- (CGSize)contentSize{
    return _containerSize;
}

@end
