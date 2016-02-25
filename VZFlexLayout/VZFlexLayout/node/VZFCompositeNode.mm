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

@implementation VZFCompositeNode
{
     
}

@synthesize node        = _node;
@synthesize flexNode    = _flexNode;

- (NodeSpecs)specs{
    return _node.specs;
}

- (ViewClass)viewClass{
    return _node.viewClass;
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
        compositeNode -> _flexNode = node.flexNode;
        [node willAddToParentNode:compositeNode];
    }
    return compositeNode;
}

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{

    return [_node computeLayoutThatFits:sz];
}

@end
