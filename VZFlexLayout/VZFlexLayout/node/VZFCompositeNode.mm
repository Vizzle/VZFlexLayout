//
//  VZFCompositeNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"
#import "VZFMacros.h"
#import "VZFNodeInternal.h"
#import "VZFNodeLayout.h"
#import "VZFScopeHandler.h"

@implementation VZFCompositeNode
{
}

- (NodeSpecs)specs{
    return _node.specs;
}

- (ViewClass)viewClass{
    return _node.viewClass;
}

- (VZFlexNode* )flexNode{
    return _node.flexNode;
}

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)newWithNode:(VZFNode *)node{

    if (!node) {
        return nil;
    }
    
    VZFCompositeNode* compositeNode = [super newWithView:{} NodeSpecs:{}];
    if (compositeNode) {
        compositeNode -> _node = node;
        
        //建立responder chain
        node.superNode = compositeNode;
        
        //关联一个boxed node
        node.boxedNode = compositeNode;
    
        
    
    }
    return compositeNode;
}

/**
 *  直接返回里面的node，composite node不参与node🌲的构建
 */
- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{

    return [_node computeLayoutThatFits:sz];
//    VZFNodeLayout layout = [_node computeLayoutThatFits:sz];
//    return {self,layout.size,layout.origin,layout.margin,*layout.children};
}

@end
