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
        
        //gesture
        VZ::Gesture gesture;
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

typedef VZ::UIAttributesSpecs VZUISpec;

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
namespace VZ {

    
    template<typename T>
    struct UIAttribute{
        

        SEL selector;
        void (^setter)(T* obj, id value);
        
        UIAttribute():selector(NULL){};
        UIAttribute(SEL sel):selector(sel),setter(^(T* obj ,id value){
            id oc_object = (id)obj;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [oc_object performSelector:selector withObject:value];
#pragma clang diagnostic pop
            
        }){};
        
        //支持hash
        bool operator == (const UIAttribute<T> &attr) const{
            return attr.selector == selector;
        };
    
    };
}

//unorded_map is not thread safe!
typedef std::unordered_map<VZ::UIAttribute<UIView>, id> VZViewAttributes;
typedef std::unordered_map<VZ::UIAttribute<CALayer>, id> VZLayerAttributes;

//支持hash
namespace std {
    template<class T>
    struct hash<VZ::UIAttribute<T>>
    {
        size_t operator()(const VZ::UIAttribute<T> &attr) const{

            return hash<std::string>()(NSStringFromSelector(attr.selector).UTF8String);
        }
    };
}



