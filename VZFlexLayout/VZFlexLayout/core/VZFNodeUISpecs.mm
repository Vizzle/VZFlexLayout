//
//  VZFNodeAttributes.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeUISpecs.h"
#import "VZFSizeRange.h"
#import "VZFlexNode.h"

namespace VZ {
    namespace DefaultFlexValue{
        
        float width = FlexAuto;
        float height = FlexAuto;
        float maxWidth = FlexInfinite;
        float maxHeight = FlexInfinite;
        float minWidth = 0;
        float minHeight = 0;
        float marginTop = 0;
        float marginBottom = 0;
        float marginLeft = 0;
        float marginRight= 0;
        float paddingLeft = 0;
        float paddingTop = 0;
        float paddingRight = 0;
        float paddingBottom = 0;
        float flexGrow = 0;
        float flexShrink = 1;
        bool fixed = 0;
        bool wrap = 0;
        int direction = FlexHorizontal;
        int justifyContent = FlexSpaceBetween;
        int alignItems = FlexStretch;
        int aliginSelf = FlexInherit;
    };
    
}



@interface VZFNodeUISpecs()

@end

@implementation VZFNodeUISpecs

+ (VZFlexNode* )flexNodeWithAttributes:(const VZ::FlexAttrs& )attrs{

    VZFlexNode* node = [VZFlexNode new];
    
    node.width              = attrs.width;
    node.height             = attrs.height;
    node.maxWidth           = attrs.maxWidth;
    node.minWidth           = attrs.minWidth;
    node.maxHeight          = attrs.maxHeight;
    node.minWidth           = attrs.minWidth;
    node.marginTop          = attrs.marginTop;
    node.marginLeft         = attrs.marginLeft;
    node.marginRight        = attrs.marginRight;
    node.marginBottom       = attrs.marginBottom;
    node.paddingTop         = attrs.paddingTop;
    node.paddingLeft        = attrs.paddingLeft;
    node.paddingRight       = attrs.paddingRight;
    node.paddingBottom      = attrs.paddingBottom;
    node.flexGrow           = attrs.flexGrow;
    node.flexShrink         = attrs.flexShrink;
    node.wrap               = attrs.wrap;
    node.fixed              = attrs.fixed;
    node.alignSelf          = (FlexAlign)((int)attrs.alignSelf);
    node.direction          = (FlexDirection)((int)attrs.stackLayout.direction);
    node.justifyContent     = (FlexAlign)((int)attrs.stackLayout.justifyContent);
    node.alignItems         = (FlexAlign)((int)attrs.stackLayout.alignItems);

    
    return node;
}

@end