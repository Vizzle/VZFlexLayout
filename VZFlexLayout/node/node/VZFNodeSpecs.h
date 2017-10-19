/*
 */
//  VZFNodeAttributes.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>
#import <string>
#import <set>
#import <unordered_map>
#import <objc/runtime.h>
#import "VZFNodeViewClass.h"
#import "VZFValue.h"
#import "VZFActionWrapper.h"
#import "VZFLength.h"


#define VZF_BOOL_UNDEFINED INT_MIN

#define VZFAutoAnimationEnabled @"enabled"
#define VZFAutoAnimationDuration @"duration"
#define VZFAutoAnimationTimingFunction @"timing-function"
#define VZFAutoAnimationDelay @"delay"

/**
 *  
 *  @Design Philosophy: 
 *  NodeSpecs 用来描述node具备的属性，通过对属性的描述，得到一个具备该属性的实体(node)
 *  也可以理解为node是一组属性的纯函数映射：f(specs) -> node， 这个映射是没有Side Effect的，固定的输入产生固定的输出
 *
 *  @Code Style: 
 *   使用C++ Struct描述，使用C++11的统一初始化函数构造Specs : {...}
 *
 *  @属性：
 *  1, 对UI属性的描述，包括UIView和CALayer常用的属性
 *  2, 对布局属性的描述，包括常用的css属性和flexbox属性
 *  3, 对手势的描述，见gesture注释
 *
 */
using namespace VZ;
namespace VZ {
    
    namespace DefaultControlAttrValue {
        extern BOOL able;
        extern BOOL disable;
    }
    
    namespace DefaultAttributesValue{
        extern int userInteractionEnabled;
        extern UIColor* backgroundColor;
        extern UIColor* highlightBackgroundColor;
        extern CGFloat cornerRadiusUndefined;
        extern CGFloat anchorX;
        extern CGFloat anchorY;
        
        //css attributes
        extern CGSize size;
        extern CGSize maxSize;
        extern CGSize minSize;
        extern FlexLength width;
        extern FlexLength height;
        extern FlexLength maxWidth;
        extern FlexLength maxHeight;
        extern FlexLength minWidth;
        extern FlexLength minHeight;
        extern FlexLength marginLeft;
        extern FlexLength marginRight;
        extern FlexLength marginTop;
        extern FlexLength marginBottom;
        extern FlexLength paddingLeft;
        extern FlexLength paddingRight;
        extern FlexLength paddingTop;
        extern FlexLength paddingBottom;
        extern FlexLength margin;
        extern FlexLength padding;
        
        //flex attributes
        extern float flexGrow;
        extern float flexShrink;
        extern FlexLength flexBasis;
        extern bool fixed;
        extern VZFlexLayoutAlignment alignSelf;
        extern float alpha;
        
        extern int isAccessibilityElement;
    };
    

    struct NodeSpecs{
        
        //Id
        std::string identifier;
        std::string globalIdentifier;
        
        //view attributes
//        BOOL hidden;
        NSInteger tag;
        BOOL clip;
        BOOL hidden;
        Value<float, DefaultAttributesValue::alpha> alpha;
        Value<int, DefaultAttributesValue::userInteractionEnabled> userInteractionEnabled;
        Value<UIColor*, DefaultAttributesValue::backgroundColor>backgroundColor;
        Value<UIColor*, DefaultAttributesValue::highlightBackgroundColor>highlightBackgroundColor; //only implemented in stacknode

        //layer attributes
        CGFloat cornerRadius;
        Value<CGFloat, DefaultAttributesValue::cornerRadiusUndefined> cornerRadiusTopLeft;
        Value<CGFloat, DefaultAttributesValue::cornerRadiusUndefined> cornerRadiusTopRight;
        Value<CGFloat, DefaultAttributesValue::cornerRadiusUndefined> cornerRadiusBottomLeft;
        Value<CGFloat, DefaultAttributesValue::cornerRadiusUndefined> cornerRadiusBottomRight;
        CGFloat borderWidth;
        UIColor* borderColor;
        Value<CGFloat, DefaultAttributesValue::anchorX> anchorX;
        Value<CGFloat, DefaultAttributesValue::anchorY> anchorY;
        UIImage* contents;
        void(^unapplicator)(UIView* view);
        void(^applicator)(UIView* view);
        
        //flex attributes
        Value<FlexLength, DefaultAttributesValue::width> width;
        Value<FlexLength, DefaultAttributesValue::height> height;
        Value<FlexLength, DefaultAttributesValue::maxWidth> maxWidth;
        Value<FlexLength, DefaultAttributesValue::maxHeight> maxHeight;
        Value<FlexLength, DefaultAttributesValue::minWidth> minWidth;
        Value<FlexLength, DefaultAttributesValue::minHeight> minHeight;
        
        Value<FlexLength, DefaultAttributesValue::marginLeft> marginLeft;
        Value<FlexLength, DefaultAttributesValue::marginRight> marginRight;
        Value<FlexLength, DefaultAttributesValue::marginTop> marginTop;
        Value<FlexLength, DefaultAttributesValue::marginBottom> marginBottom;
        
        Value<FlexLength, DefaultAttributesValue::paddingLeft> paddingLeft;
        Value<FlexLength, DefaultAttributesValue::paddingRight> paddingRight;
        Value<FlexLength, DefaultAttributesValue::paddingTop> paddingTop;
        Value<FlexLength, DefaultAttributesValue::paddingBottom> paddingBottom;
        
        Value<FlexLength, DefaultAttributesValue::margin> margin;
        Value<FlexLength, DefaultAttributesValue::padding> padding;
        
        Value<float, DefaultAttributesValue::flexGrow> flexGrow;
        Value<float, DefaultAttributesValue::flexShrink> flexShrink;
        Value<FlexLength, DefaultAttributesValue::flexBasis> flexBasis;
        Value<VZFlexLayoutAlignment,  DefaultAttributesValue::alignSelf> alignSelf;
        Value<bool, DefaultAttributesValue::fixed> fixed;
        
        //blind supporting
        Value<int, DefaultAttributesValue::userInteractionEnabled> isAccessibilityElement;
        NSString* accessibilityLabel;
        
        VZFBlockGesture *gesture; // deprecated, use `gestures` instead
        std::vector<VZFBlockGesture *> gestures;
        VZFBlockAction *display;
        VZFBlockAction *updateAppear;
        VZFBlockAction *updateDisappear;
        VZFBlockAction *updateReuse;

        NSDictionary *autoAnimationAttributes;
        BOOL asyncDisplay;
    };

}
