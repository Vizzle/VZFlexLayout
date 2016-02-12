//
//  VZFNodeAttributes.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>
#include <string>
#include <set>
#import <unordered_map>
#import <objc/runtime.h>
#import "VZFNodeViewClass.h"
#import "VZFValue.h"
#import "VZFGesture.h"

using namespace VZ;

namespace VZ {
    
    struct LayerAttrs{
        
        CGFloat cornerRadius;
        CGFloat borderWidth;
        UIColor* borderColor;
        UIImage* contents;
    };
    
    struct ViewAttrs{
        
        UIColor* backgroundColor;
        UIViewContentMode contentMode;
        BOOL clipToBounds;
        LayerAttrs layer;
    };
    

    namespace DefaultFlexValue{
        
        //UI attributes
        extern CGSize size;
        extern CGSize maxSize;
        extern CGSize minSize;
        extern float width;
        extern float height;
        extern float maxWidth;
        extern float maxHeight;
        extern float minWidth;
        extern float minHeight;
        
        //css attributes
        extern float marginLeft;
        extern float marginRight;
        extern float marginTop;
        extern float marginBottom;
        
        extern float paddingLeft;
        extern float paddingRight;
        extern float paddingTop;
        extern float paddingBottom;
        
        //flex attributes
        extern float flexGrow;
        extern float flexShrink;
        extern bool fixed;
        extern bool wrap;

    };
    

    struct FlexAttrs{

        Value<float, DefaultFlexValue::width> width;
        Value<float, DefaultFlexValue::height> height;
        Value<float, DefaultFlexValue::maxWidth> maxWidth;
        Value<float, DefaultFlexValue::maxHeight> maxHeight;
        Value<float, DefaultFlexValue::minWidth> minWidth;
        Value<float, DefaultFlexValue::minHeight> minHeight;
        
        Value<float, DefaultFlexValue::marginLeft> marginLeft;
        Value<float, DefaultFlexValue::marginRight> marginRight;
        Value<float, DefaultFlexValue::marginTop> marginTop;
        Value<float, DefaultFlexValue::marginBottom> marginBottom;
        
         Value<float, DefaultFlexValue::paddingLeft> paddingLeft;
         Value<float, DefaultFlexValue::paddingRight> paddingRight;
         Value<float, DefaultFlexValue::paddingTop> paddingTop;
         Value<float, DefaultFlexValue::paddingBottom> paddingBottom;
        
         Value<float, DefaultFlexValue::flexGrow> flexGrow;
         Value<float, DefaultFlexValue::flexShrink> flexShrink;
        
         Value<bool, DefaultFlexValue::fixed> fixed;
         Value<bool, DefaultFlexValue::wrap> wrap;
    
    };

    
    struct UIAttributesSpecs{
        
        //view class
         ViewClass clz;
        
        //view / layer properties
        struct ViewAttrs view;
        
        //flex
        struct FlexAttrs flex;
        
        //gestures
        struct std::set<Gesture> gestures;
        
    };
}

typedef  UIAttributesSpecs VZUISpecs;



//支持UIView和CALayer
//namespace VZ {
//
//    
//    template<typename T>
//    struct UIAttribute{
//        
//
//        SEL selector;
//        void (^setter)(T* obj, id value);
//        
//        UIAttribute():selector(NULL){};
//        UIAttribute(SEL sel):selector(sel),setter(^(T* obj ,id value){
//            id oc_object = (id)obj;
//            
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            [oc_object performSelector:selector withObject:value];
//#pragma clang diagnostic pop
//            
//        }){};
//        
//        //支持hash
//        bool operator == (const UIAttribute<T> &attr) const{
//            return attr.selector == selector;
//        };
//    
//    };
//}
//
////unorded_map is not thread safe!
//typedef std::unordered_map< UIAttribute<UIView>, id> VZViewAttributes;
//typedef std::unordered_map< UIAttribute<CALayer>, id> VZLayerAttributes;
//
////支持hash
//namespace std {
//    template<class T>
//    struct hash< UIAttribute<T>>
//    {
//        size_t operator()(const  UIAttribute<T> &attr) const{
//
//            return hash<std::string>()(NSStringFromSelector(attr.selector).UTF8String);
//        }
//    };
//}



