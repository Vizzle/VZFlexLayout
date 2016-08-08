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
    
    namespace DefaultAttributesValue{
        UIColor* backgroundColor = [UIColor clearColor];
        UIColor* highlightBackgroundColor = nil;
        int userInteractionEnabled = INT_MIN;
        CGFloat cornerRadiusUndefined = VZ::FlexValue::Undefined;
        
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
        VZFlexLayoutAlignment alignSelf = VZFlexInherit;
    }
    
}
