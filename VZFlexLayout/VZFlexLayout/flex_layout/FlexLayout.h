
#pragma once

#include "Inset.h"
#include "Length.h"
#include "Value.h"
#include "Color.h"
#include "Node.h"
#include "Property.h"
#include "Enum.h"
#include "FNViewAttribute.h"

#include <string>
#include <memory>
#include <vector>
#include <unordered_map>

#include <objc/runtime.h>

namespace flex{
    
    REFLECT_ENUM(FlexDirection,
        Horizontal,
        Vertical,
    )
    
    REFLECT_ENUM(FlexAlign,
        Auto,
        Stretch,
        Center,
        Start,
        End,
//        Baseline,
    )
    
    REFLECT_ENUM(FlexJustify,
        Start,
        End,
        Center,
        SpaceBetween,
        SpaceAround,
    )
    
    struct FlexLayoutResult {
        Float left;
        Float top;
        Float width;
        Float height;
        Float marginTop;
        Float marginLeft;
        Float marginBottom;
        Float marginRight;
        Float paddingTop;
        Float paddingLeft;
        Float paddingBottom;
        Float paddingRight;
    };
    
    
    struct ClassWrapper {
        Class cls;
        
        ClassWrapper() {}
        ClassWrapper(Class cls) : cls(cls) {}
        ClassWrapper(std::string name) : cls([NSString stringWithUTF8String:name.c_str()]) {}
        
        bool operator==(const ClassWrapper& other) const {
            return cls == other.cls;
        }
    };
    
    template<>
    struct PropertyCast<ClassWrapper> {
        static std::string toString(const ClassWrapper& value) {
            return value.cls ? NSStringFromClass(value.cls).UTF8String : "nil";
        }
        
        static ClassWrapper fromString(const std::string& str) {
            Class cls = NSClassFromString([NSString stringWithUTF8String:str.c_str()]);
            if (![cls isSubclassOfClass:[OSView class]]) {
                cls = nil;
            }
            return cls;
        }
    };
    
    
#define PROPERTIES \
PROPERTY(std::string, name, "", "Basic") \
PROPERTY(Color, backColor, 0U, "Style") \
PROPERTY(Color, borderColor, 0xff000000, "Style") \
PROPERTY(Float, borderWidth, 0, "Style") \
PROPERTY(Float, cornerRadius, 0, "Style") \
PROPERTY(bool, fixed, false, "Layout") \
PROPERTY(FlexDirection, direction, FlexDirection::Horizontal, "FlexBox") \
PROPERTY(FlexJustify, justifyContent, FlexJustify::Start, "FlexBox") \
PROPERTY(FlexAlign, alignItems, FlexAlign::Stretch, "FlexBox") \
PROPERTY(FlexAlign, alignSelf, FlexAlign::Auto, "FlexBox") \
PROPERTY(Length, flexBasis, Auto, "FlexBox", "", {{"auto", Auto}, {"content", Content}}) \
PROPERTY(Float, flexGrow, 0, "FlexBox") \
PROPERTY(Float, flexShrink, 1, "FlexBox") \
PROPERTY(Length, width, Auto, "Layout", "", {{"auto", Auto}}) \
PROPERTY(Length, height, Auto, "Layout", "", {{"auto", Auto}}) \
PROPERTY(Float, minWidth, 0, "Layout") \
PROPERTY(Float, minHeight, 0, "Layout") \
PROPERTY(Float, maxWidth, Infinite, "Layout", "", {{"infinite", Infinite}}) \
PROPERTY(Float, maxHeight, Infinite, "Layout", "", {{"infinite", Infinite}}) \
PROPERTY(Inset, margin, 0, "Layout", "", {{"auto", Auto}}) \
PROPERTY(Float, marginTop, Undefined, "Layout", "", {{"undefined", Undefined}, {"auto", Auto}}) \
PROPERTY(Float, marginLeft, Undefined, "Layout", "", {{"undefined", Undefined}, {"auto", Auto}}) \
PROPERTY(Float, marginBottom, Undefined, "Layout", "", {{"undefined", Undefined}, {"auto", Auto}}) \
PROPERTY(Float, marginRight, Undefined, "Layout", "", {{"undefined", Undefined}, {"auto", Auto}}) \
PROPERTY(Inset, padding, 0, "Layout") \
PROPERTY(Float, paddingTop, Undefined, "Layout", "", {{"undefined", Undefined}}) \
PROPERTY(Float, paddingLeft, Undefined, "Layout", "", {{"undefined", Undefined}}) \
PROPERTY(Float, paddingBottom, Undefined, "Layout", "", {{"undefined", Undefined}}) \
PROPERTY(Float, paddingRight, Undefined, "Layout", "", {{"undefined", Undefined}}) \
PROPERTY(Float, spacing, 0, "Layout") \
PROPERTY(ClassWrapper, viewClass, nil, "View") \
    
    namespace Defaults {
#define PROPERTY(CLASS, NAME, DEFAULT, ...) extern CLASS NAME;
        PROPERTIES
#undef  PROPERTY
    }
    
    struct FlexLayout {
        
        NodeWraper content;
        std::vector<FlexLayout> children;
        std::unordered_map<FNViewAttribute, id> attrs;
        FlexLayoutResult result;

#define PROPERTY(CLASS, NAME, DEFAULT, ...) Value<CLASS, Defaults::NAME> NAME;
        PROPERTIES
#undef  PROPERTY
        
    };
//    
//    void test(){
//    
//    };
//    
    void layout(FlexLayout& flex, Size constraintedSize);
    
}
