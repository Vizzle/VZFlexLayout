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
    
    namespace DefaultControlAttrValue {
        BOOL able = YES;
        BOOL disable = NO;
    }
    
    namespace DefaultAttributesValue{
        UIColor* backgroundColor = [UIColor clearColor];
        UIColor* highlightBackgroundColor = nil;
        int userInteractionEnabled = VZF_BOOL_UNDEFINED;
        CGFloat cornerRadiusUndefined = VZ::FlexValue::Undefined();
        CGFloat anchorX = 0.5;
        CGFloat anchorY = 0.5;
        
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
        FlexLength flexBasis = FlexLengthAuto;
        bool fixed = 0;
        float alpha = 1;
        
        VZFlexLayoutAlignment alignSelf = VZFlexInherit;
        BOOL asyncDisplay = NO;
        int isAccessibilityElement = VZF_BOOL_UNDEFINED;        
    }
    
}
