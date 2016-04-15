//
//  VZFlexNode+VZFNode.m
//  O2OReact
//
//  Created by moxin on 16/4/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFlexNode+VZFNode.h"
#import <objc/runtime.h>

const void* g_flexNode = &g_flexNode;
@implementation VZFlexNode (VZFNode)

- (void)setFNode:(VZFNode *)fNode{
    objc_setAssociatedObject(self, g_flexNode, fNode, OBJC_ASSOCIATION_ASSIGN);
}

- (VZFNode* )fNode{
    return objc_getAssociatedObject(self, g_flexNode);
}

@end
