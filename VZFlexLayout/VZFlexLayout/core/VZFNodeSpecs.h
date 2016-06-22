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
    

    namespace DefaultUIAttributesValue{
        extern int userInteractionEnabled;
        extern UIColor* backgroundColor;
        extern UIColor* highlightBackgroundColor;
        extern CGFloat cornerRadiusUndefined;
    }
    
    
    namespace DefaultFlexAttributesValue{
        
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
        extern bool wrap;
        extern VZFlexLayoutAlignment alignSelf;

    };
    
    
    struct LayerAttrs{
        
        CGFloat cornerRadius;
        Value<CGFloat, DefaultUIAttributesValue::cornerRadiusUndefined> cornerRadiusTopLeft;
        Value<CGFloat, DefaultUIAttributesValue::cornerRadiusUndefined> cornerRadiusTopRight;
        Value<CGFloat, DefaultUIAttributesValue::cornerRadiusUndefined> cornerRadiusBottomLeft;
        Value<CGFloat, DefaultUIAttributesValue::cornerRadiusUndefined> cornerRadiusBottomRight;
        
        CGFloat borderWidth;
        UIColor* borderColor;
        UIImage* contents;
    };
    
    struct ViewAttrs{
        BOOL hidden;
        NSInteger tag;
        BOOL clip;
        Value<int, DefaultUIAttributesValue::userInteractionEnabled> userInteractionEnabled;
        Value<UIColor*, DefaultUIAttributesValue::backgroundColor>backgroundColor;
        Value<UIColor*, DefaultUIAttributesValue::highlightBackgroundColor>highlightBackgroundColor; //only implemented in stacknode
        struct LayerAttrs layer;
        void(^unapplicator)(UIView* view);
        void(^applicator)(UIView* view);
    };
    

    struct FlexAttrs{

        Value<FlexLength, DefaultFlexAttributesValue::width> width;
        Value<FlexLength, DefaultFlexAttributesValue::height> height;
        Value<FlexLength, DefaultFlexAttributesValue::maxWidth> maxWidth;
        Value<FlexLength, DefaultFlexAttributesValue::maxHeight> maxHeight;
        Value<FlexLength, DefaultFlexAttributesValue::minWidth> minWidth;
        Value<FlexLength, DefaultFlexAttributesValue::minHeight> minHeight;
        
        Value<FlexLength, DefaultFlexAttributesValue::marginLeft> marginLeft;
        Value<FlexLength, DefaultFlexAttributesValue::marginRight> marginRight;
        Value<FlexLength, DefaultFlexAttributesValue::marginTop> marginTop;
        Value<FlexLength, DefaultFlexAttributesValue::marginBottom> marginBottom;
        
        Value<FlexLength, DefaultFlexAttributesValue::paddingLeft> paddingLeft;
        Value<FlexLength, DefaultFlexAttributesValue::paddingRight> paddingRight;
        Value<FlexLength, DefaultFlexAttributesValue::paddingTop> paddingTop;
        Value<FlexLength, DefaultFlexAttributesValue::paddingBottom> paddingBottom;
        
        Value<FlexLength, DefaultFlexAttributesValue::margin> margin;
        Value<FlexLength, DefaultFlexAttributesValue::padding> padding;
        
        Value<float, DefaultFlexAttributesValue::flexGrow> flexGrow;
        Value<float, DefaultFlexAttributesValue::flexShrink> flexShrink;
        Value<FlexLength, DefaultFlexAttributesValue::flexBasis> flexBasis;
        Value<VZFlexLayoutAlignment,  DefaultFlexAttributesValue::alignSelf> alignSelf;
        Value<bool, DefaultFlexAttributesValue::fixed> fixed;
        Value<bool, DefaultFlexAttributesValue::wrap> wrap;
        
    };
    
    
    template<>
    struct MultiMapKey<Class> {
        static Class defaultKey;
    };
    
    template<typename GestureType>
    MultiMap<Class, ActionWrapper>::value_type VZFGesture(const ActionWrapper& action) {
        static_assert(std::is_convertible<GestureType, UIGestureRecognizer>::value_type, "is not gesture recognizer class");
        return { [GestureType class], action };
    }
    

    struct NodeSpecs{
        
        //name
        std::string identifier;

        //view / layer properties
        struct ViewAttrs view;
        
        //flex
        struct FlexAttrs flex;
        
        /*
            gestures
         
            .gesture = @selector(xx),
            .gesture = ^(id sender){},
            .gesture = VZFGesture<UITapGestureRecognizer>(@selector(xx)),
            .gesture = {
                VZFGesture<UITapGestureRecognizer>(@selector(xx)),
                VZFGesture<UITapGestureRecognizer>(^(id sender){}),
            },
            .gesture = {
                { UITapGestureRecognizer, @selector(xx) },
                { UITapGestureRecognizer, ^(id sender){} },
            }
         */
        MultiMap<Class, ActionWrapper> gesture;
    };

}
