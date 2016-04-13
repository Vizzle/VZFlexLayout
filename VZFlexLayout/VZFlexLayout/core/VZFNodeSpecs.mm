//
//  VZFNodeAttributes.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeSpecs.h"
#import "VZFSizeRange.h"
#import "VZFlexNode.h"
#import "VZFLength.h"

namespace VZ {
    
    Class MultiMapKey<Class>::defaultKey = [UITapGestureRecognizer class];
    
    namespace DefaultFlexValue{
        
        FlexLength width = FlexLengthAuto;
        FlexLength height = FlexLengthAuto;
        FlexLength maxWidth = FlexLengthUndefined;
        FlexLength maxHeight = FlexLengthUndefined;
        FlexLength minWidth = FlexLengthZero;
        FlexLength minHeight = FlexLengthZero;
        FlexLength marginTop = FlexLengthUndefined;
        FlexLength marginBottom = FlexLengthUndefined;
        FlexLength marginLeft = FlexLengthUndefined;
        FlexLength marginRight= FlexLengthUndefined;
        FlexLength paddingLeft = FlexLengthUndefined;
        FlexLength paddingTop = FlexLengthUndefined;
        FlexLength paddingRight = FlexLengthUndefined;
        FlexLength paddingBottom = FlexLengthUndefined;
        FlexLength margin = FlexLengthZero;
        FlexLength padding = FlexLengthZero;
        float flexGrow = 0;
        float flexShrink = 1;
        FlexLength flexBasis = FlexLengthUndefined;
        bool fixed = 0;
        bool wrap = 0;
        int direction = FlexHorizontal;
        int justifyContent = FlexStart;
        int alignItems = FlexStretch;
        int aliginSelf = FlexInherit;
        float spacing = 0;
        float lineSpacing = 0;
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
    node.wrap               = attrs.wrap;
    node.fixed              = attrs.fixed;
    node.alignSelf          = (FlexAlign)((int)attrs.alignSelf);
    node.direction          = (FlexDirection)((int)attrs.stackLayout.direction);
    node.justifyContent     = (FlexAlign)((int)attrs.stackLayout.justifyContent);
    node.alignItems         = (FlexAlign)((int)attrs.stackLayout.alignItems);
    node.spacing            = attrs.stackLayout.spacing;
    node.lineSpacing        = attrs.stackLayout.lineSpacing;

    
    return node;
}

@end