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

using namespace VZ;
namespace VZ {
    
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
    

    namespace DefaultFlexValue{
        
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

        Value<int, DefaultFlexValue::direction> direction;
        Value<int, DefaultFlexValue::alignItems> alignItems;
        Value<int, DefaultFlexValue::justifyContent> justifyContent;
        
        Value<float, DefaultFlexValue::spacing> spacing;
        Value<float, DefaultFlexValue::lineSpacing> lineSpacing;
        
    };

    struct FlexAttrs{

        Value<FlexLength, DefaultFlexValue::width> width;
        Value<FlexLength, DefaultFlexValue::height> height;
        Value<FlexLength, DefaultFlexValue::maxWidth> maxWidth;
        Value<FlexLength, DefaultFlexValue::maxHeight> maxHeight;
        Value<FlexLength, DefaultFlexValue::minWidth> minWidth;
        Value<FlexLength, DefaultFlexValue::minHeight> minHeight;
        
        Value<FlexLength, DefaultFlexValue::marginLeft> marginLeft;
        Value<FlexLength, DefaultFlexValue::marginRight> marginRight;
        Value<FlexLength, DefaultFlexValue::marginTop> marginTop;
        Value<FlexLength, DefaultFlexValue::marginBottom> marginBottom;
        
        Value<FlexLength, DefaultFlexValue::paddingLeft> paddingLeft;
        Value<FlexLength, DefaultFlexValue::paddingRight> paddingRight;
        Value<FlexLength, DefaultFlexValue::paddingTop> paddingTop;
        Value<FlexLength, DefaultFlexValue::paddingBottom> paddingBottom;
        
        Value<FlexLength, DefaultFlexValue::margin> margin;
        Value<FlexLength, DefaultFlexValue::padding> padding;
        
        Value<float, DefaultFlexValue::flexGrow> flexGrow;
        Value<float, DefaultFlexValue::flexShrink> flexShrink;
        Value<FlexLength, DefaultFlexValue::flexBasis> flexBasis;
        Value<int,  DefaultFlexValue::aliginSelf> alignSelf;
        Value<bool, DefaultFlexValue::fixed> fixed;
        Value<bool, DefaultFlexValue::wrap> wrap;
        
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

typedef NS_ENUM(int, VZFlexValue){

    VZFlexValueUndefined = -999999,  // used in properties: marginTop, paddingTop, ...
    VZFlexValueInfinite = -999998, // used in constraintedSize, maxWidth, maxHeight
    VZFlexValueAuto = -999997,   // used in properties: flexBasis, width, height, margin, padding, marginTop, ...
    VZFlexValueContent = -999996        // used in properties: flexBasis
    
};


@class VZFlexNode;
@interface VZFNodeUISpecs : NSObject

+ (VZFlexNode* )flexNodeWithAttributes:(const VZ::FlexAttrs& )attrs;

@end
