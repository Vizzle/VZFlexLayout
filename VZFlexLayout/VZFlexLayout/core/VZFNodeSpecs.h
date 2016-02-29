//
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
        
        NSInteger tag;
        BOOL clipToBounds;
        UIColor* backgroundColor;
        LayerAttrs layer;
        void(^block)(UIView* view);
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
        
        extern float margin;
        extern float padding;
        
        //flex attributes
        extern float flexGrow;
        extern float flexShrink;
        extern float flexBasis;
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
        
        Value<float, DefaultFlexValue::margin> margin;
        Value<float, DefaultFlexValue::padding> padding;
        
        Value<float, DefaultFlexValue::flexGrow> flexGrow;
        Value<float, DefaultFlexValue::flexShrink> flexShrink;
        Value<float, DefaultFlexValue::flexBasis> flexBasis;
        Value<int,  DefaultFlexValue::aliginSelf> alignSelf;
        Value<bool, DefaultFlexValue::fixed> fixed;
        Value<bool, DefaultFlexValue::wrap> wrap;
        
        //describe stack layout specs
        struct StackLayoutSpecs stackLayout;
    
    };
    
    typedef struct{}ViewNodeSpecs;

    template<typename T>
    struct UISpecs{
        
        //name
        std::string name;

        //view / layer properties
        struct ViewAttrs view;
        
        //flex
        struct FlexAttrs flex;
        
        //gestures
        struct std::set<Gesture> gestures;
        
        //other type of UISpecs
        T attrs;
    };
}

typedef VZ::UISpecs<ViewNodeSpecs> NodeSpecs;

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
