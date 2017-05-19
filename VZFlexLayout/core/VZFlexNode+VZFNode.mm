//
//  VZFlexNode+VZFNode.m
//  O2OReact
//
//  Created by moxin on 16/4/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFlexNode+VZFNode.h"
#import "VZFMacros.h"
#import <objc/runtime.h>


//force the category methods to be compiled
VZF_FORCE_CATEGORY_COMPILE(VZFlexNode_VZFNode)

const void* g_flexNode = &g_flexNode;
@implementation VZFlexNode (VZFNode)

- (void)setFNode:(VZFNode *)fNode{
    objc_setAssociatedObject(self, g_flexNode, fNode, OBJC_ASSOCIATION_ASSIGN);
}

- (VZFNode* )fNode{
    return objc_getAssociatedObject(self, g_flexNode);
}

+ (VZFlexNode* )flexNodeWithSpecs:(const NodeSpecs& )attrs{

    VZFlexNode* node = [VZFlexNode new];
    
    node.width              = attrs.width;
    node.height             = attrs.height;
    node.maxWidth           = attrs.maxWidth;
    node.minWidth           = attrs.minWidth;
    node.maxHeight          = attrs.maxHeight;
    node.minHeight          = attrs.minHeight;
    node.marginTop          = attrs.marginTop != FlexLengthUndefined ? (FlexLength)attrs.marginTop : (FlexLength)attrs.margin;
    node.marginLeft         = attrs.marginLeft != FlexLengthUndefined ? (FlexLength)attrs.marginLeft : (FlexLength)attrs.margin;
    node.marginRight        = attrs.marginRight != FlexLengthUndefined ? (FlexLength)attrs.marginRight : (FlexLength)attrs.margin;
    node.marginBottom       = attrs.marginBottom != FlexLengthUndefined ? (FlexLength)attrs.marginBottom : (FlexLength)attrs.margin;
    node.paddingTop         = attrs.paddingTop != FlexLengthUndefined ? (FlexLength)attrs.paddingTop : (FlexLength)attrs.padding;
    node.paddingLeft        = attrs.paddingLeft != FlexLengthUndefined ? (FlexLength)attrs.paddingLeft : (FlexLength)attrs.padding;
    node.paddingRight       = attrs.paddingRight != FlexLengthUndefined ? (FlexLength)attrs.paddingRight : (FlexLength)attrs.padding;
    node.paddingBottom      = attrs.paddingBottom != FlexLengthUndefined ? (FlexLength)attrs.paddingBottom : (FlexLength)attrs.padding;
    node.flexGrow           = attrs.flexGrow;
    node.flexShrink         = attrs.flexShrink;
    node.flexBasis          = attrs.flexBasis;
    node.fixed              = attrs.fixed;
    node.alignSelf          = (FlexAlign)((int)attrs.alignSelf);

    return node;
}



- (void)applyStackLayoutAttributes:(const VZ::StackNodeSpecs &)stackSpecs{
    
    
    self.direction          = (FlexDirection)((int)stackSpecs.direction);
    self.justifyContent     = (FlexAlign)((int)stackSpecs.justifyContent);
    self.alignItems         = (FlexAlign)((int)stackSpecs.alignItems);
    self.alignContent       = (FlexAlign)((int)stackSpecs.alignContent);
    self.spacing            = stackSpecs.spacing;
    self.lineSpacing        = stackSpecs.lineSpacing;
    self.wrap               = (FlexWrapMode)((int)stackSpecs.wrap);
    self.lines              = stackSpecs.lines;
    self.itemsPerLine       = stackSpecs.itemsPerLine;

}
@end
