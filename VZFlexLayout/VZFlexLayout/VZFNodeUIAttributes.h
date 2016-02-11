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
#import <unordered_map>
#import <objc/runtime.h>
#import "VZFNodeViewClass.h"
#import "VZFValue.h"


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
        
        VZ::Value<CGSize, DefaultFlexValue::size> size;
        VZ::Value<CGSize, DefaultFlexValue::maxSize> maxSize;
        VZ::Value<CGSize, DefaultFlexValue::minSize> minSize;
        
        VZ::Value<float, DefaultFlexValue::marginLeft> marginLeft;
        VZ::Value<float, DefaultFlexValue::marginRight> marginRight;
        VZ::Value<float, DefaultFlexValue::marginTop> marginTop;
        VZ::Value<float, DefaultFlexValue::marginBottom> marginBottom;
        
        VZ::Value<float, DefaultFlexValue::paddingLeft> paddingLeft;
        VZ::Value<float, DefaultFlexValue::paddingRight> paddingRight;
        VZ::Value<float, DefaultFlexValue::paddingTop> paddingTop;
        VZ::Value<float, DefaultFlexValue::paddingBottom> paddingBottom;
        
        VZ::Value<float, DefaultFlexValue::flexGrow> flexGrow;
        VZ::Value<float, DefaultFlexValue::flexShrink> flexShrink;
        
        VZ::Value<bool, DefaultFlexValue::fixed> fixed;
        VZ::Value<bool, DefaultFlexValue::wrap> wrap;
    
    };

    enum class GestureType{
        
        Tap = 0,
        LongPress= 1,
        Undefined = -1
    };
    
    
    typedef void(^gestureBlock)(id sender);
    
    struct Gesture{
    
        Gesture():type(GestureType::Undefined),name("undefined"){};
        Gesture(GestureType t):type(t){
        
            switch(t)
            {
                case GestureType::Tap:
                {
                    name = "tap";
                    break;
                }
                case GestureType::LongPress:
                {
                    name = "longpress";
                    break;
                }
                default:
                {
                    name ="undefined";
                    break;
                }
            }
        };
            
        GestureType type = GestureType::Undefined;
        std::string name = "undefined";

        //支持hash
        bool operator == (const Gesture &gesture) const{
            return gesture.type == this->type;
        };
    };

  
    
    
    typedef std::unordered_map<Gesture, gestureBlock> gesture_t;
    
    
    struct UIAttributesSpecs{
        
        //view class
        VZ::ViewClass clz;
        
        //view / layer properties
        struct ViewAttrs view;
        
        //flex
        struct FlexAttrs flex;
        
        //gesture
        NSArray<NSDictionary* >* gestures;
//        VZ::Gesture gesture;
//        std::unordered_map<Gesture, gestureBlock> gesture;
        
        
    };
//    
//    std::shared_ptr<gesture_t> GestureBuilder(Gesture type, gestureBlock callback)
//    {
//        gesture_t* map = new gesture_t{
//        
//        };
//        
//    }
}

typedef VZ::UIAttributesSpecs VZUISpecs;

namespace std {
    
    //provide a hash key
    template<> struct hash<VZ::Gesture>
    {
        size_t operator()(const VZ::Gesture &gesture) const{
            return std::hash<std::string>()(gesture.name);
        }
    };
}

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
//typedef std::unordered_map<VZ::UIAttribute<UIView>, id> VZViewAttributes;
//typedef std::unordered_map<VZ::UIAttribute<CALayer>, id> VZLayerAttributes;
//
////支持hash
//namespace std {
//    template<class T>
//    struct hash<VZ::UIAttribute<T>>
//    {
//        size_t operator()(const VZ::UIAttribute<T> &attr) const{
//
//            return hash<std::string>()(NSStringFromSelector(attr.selector).UTF8String);
//        }
//    };
//}



