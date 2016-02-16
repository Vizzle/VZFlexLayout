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
        float marginTop = FlexUndefined;
        float marginBottom = FlexUndefined;
        float marginLeft = FlexUndefined;
        float marginRight= FlexUndefined;
        float paddingLeft = FlexUndefined;
        float paddingTop = FlexUndefined;
        float paddingRight = FlexUndefined;
        float paddingBottom = FlexUndefined;
        float margin = 0;
        float padding = 0;
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
    node.marginTop          = attrs.marginTop != FlexUndefined ? attrs.marginTop.value : attrs.margin.value;
    node.marginLeft         = attrs.marginLeft != FlexUndefined ? attrs.marginLeft.value : attrs.margin.value;
    node.marginRight        = attrs.marginRight != FlexUndefined ? attrs.marginRight.value : attrs.margin.value;
    node.marginBottom       = attrs.marginBottom != FlexUndefined ? attrs.marginBottom.value : attrs.margin.value;
    node.paddingTop         = attrs.paddingTop != FlexUndefined ? attrs.paddingTop.value : attrs.padding.value;
    node.paddingLeft        = attrs.paddingLeft != FlexUndefined ? attrs.paddingLeft.value : attrs.padding.value;
    node.paddingRight       = attrs.paddingRight != FlexUndefined ? attrs.paddingRight.value : attrs.padding.value;
    node.paddingBottom      = attrs.paddingBottom != FlexUndefined ? attrs.paddingBottom.value : attrs.padding.value;
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