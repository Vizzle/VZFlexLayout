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
#import "FlexLayout.h"
#import "VZFLength.h"

using namespace VZ;
namespace VZ {

    namespace FlexValue{
        const float Undefined = FlexUndefined;
        const float Auto = FlexAuto;
    }
    
    struct LayerAttrs{
        
        CGFloat cornerRadius;
        CGFloat borderWidth;
        UIColor* borderColor;
        UIImage* contents;
    };
    
    struct ViewAttrs{
        
        NSInteger tag;
        BOOL clipsToBounds;
        UIColor* backgroundColor;
        struct LayerAttrs layer;
        void(^block)(UIView* view);
    };
    
    namespace DefaultFlexAttributesValue{
        
        //UI attributes
        extern CGSize size;
        extern CGSize maxSize;
        extern CGSize minSize;
        extern FlexLength width;
        extern FlexLength height;
        extern FlexLength maxWidth;
        extern FlexLength maxHeight;
        extern FlexLength minWidth;
        extern FlexLength minHeight;
        
        //css attributes
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
        extern int direction;
        extern int justifyContent;
        extern int alignItems;
        extern int aliginSelf;

        extern float spacing;
        extern float lineSpacing;
    };
    

    struct StackLayoutSpecs{

        Value<int, DefaultFlexAttributesValue::direction> direction;
        Value<int, DefaultFlexAttributesValue::alignItems> alignItems;
        Value<int, DefaultFlexAttributesValue::justifyContent> justifyContent;
        
        Value<float, DefaultFlexAttributesValue::spacing> spacing;
        Value<float, DefaultFlexAttributesValue::lineSpacing> lineSpacing;
        
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
        Value<int,  DefaultFlexAttributesValue::aliginSelf> alignSelf;
        Value<bool, DefaultFlexAttributesValue::fixed> fixed;
        Value<bool, DefaultFlexAttributesValue::wrap> wrap;
        
        //describe stack layout specs
        struct StackLayoutSpecs stackLayout;
    
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

/**
 typedef enum {
 FlexHorizontal,
 FlexVertical
 } FlexDirection;
 */
typedef NS_ENUM(int, VZFlexLayoutDirection){
    VZFlexHorizontal,
    VZFlexVertical
};
/**
 typedef enum {
 FlexInherit,
 FlexStretch,
 FlexStart,
 FlexCenter,
 FlexEnd,
 FlexSpaceBetween,
 FlexSpaceAround
 } FlexAlign;
 */
typedef NS_ENUM(int, VZFlexLayoutAlignment){

    VZFlexInherit,
    VZFlexStretch,
    VZFlexStart,
    VZFlexCenter,
    VZFlexEnd,
    VZFlexSpaceBetween,
    VZFlexSpaceAround

};



@class VZFlexNode;
@interface VZFNodeUISpecs : NSObject

+ (VZFlexNode* )flexNodeWithAttributes:(const VZ::FlexAttrs& )attrs;

@end
