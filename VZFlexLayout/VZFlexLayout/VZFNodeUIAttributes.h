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



