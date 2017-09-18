//
//  FlexLayout.h
//  flex_layout
//
//  Created by Sleen on 16/1/25.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#pragma once

#ifdef __cplusplus
extern "C"{
#endif

#include <stddef.h>
#ifndef __cplusplus
#   include <stdbool.h>
#endif

#include "FlexProperties.h"

typedef enum {
    FlexHorizontal,
    FlexVertical,
    FlexHorizontalReverse,
    FlexVerticalReverse
} FlexDirection;

typedef enum {
    FlexNoWrap,
    FlexWrap,
    FlexWrapReverse,
} FlexWrapMode;

typedef enum {
    FlexInherit,
    FlexStretch,
    FlexStart,
    FlexCenter,
    FlexEnd,
    FlexSpaceBetween,
    FlexSpaceAround,
    FlexBaseline,
} FlexAlign;

typedef enum {
    FLEX_LEFT = 0,
    FLEX_TOP,
    FLEX_RIGHT,
    FLEX_BOTTOM,
    FLEX_START,
    FLEX_END
} FlexPositionIndex;

typedef enum {
    FlexLengthTypeDefault,
    FlexLengthTypePercent,
    FlexLengthTypePx,
    FlexLengthTypeCm,       // 1cm = 96px/2.54
    FlexLengthTypeMm,       // 1mm = 1/10th of 1cm
    FlexLengthTypeQ,        // 1q = 1/40th of 1cm
    FlexLengthTypeIn,       // 1in = 2.54cm = 96px
    FlexLengthTypePc,       // 1pc = 1/6th of 1in
    FlexLengthTypePt,       // 1pt = 1/72th of 1in
    FlexLengthTypeEm,       // font size of element
//    FlexLengthTypeEx,       // x-height of the element’s font
//    FlexLengthTypeCh,       // width of the "0" (ZERO, U+0030) glyph in the element’s font
//    FlexLengthTypeRem,      // font size of the root element
    FlexLengthTypeVw,       // 1% of viewport’s width
    FlexLengthTypeVh,       // 1% viewport’s height
    FlexLengthTypeVmin,     // 1% of viewport’s smaller dimension
    FlexLengthTypeVmax      // 1% of viewport’s larger dimension
} FlexLengthType;

typedef struct {
    float value;
    FlexLengthType type;
} FlexLength;

typedef union {
    struct {
        float width;
        float height;
    };
    float size[2];
} FlexSize;


typedef struct FlexNode * FlexNodeRef;

typedef FlexSize (*FlexMeasureFunc)(void* context, FlexSize constrainedSize);
typedef float (*FlexBaselineFunc)(void* context, FlexSize constrainedSize);
typedef FlexNodeRef (*FlexChildAtFunc)(void* context, size_t index);

inline FlexLength flexLength(float value, FlexLengthType type) {
    FlexLength r;
    r.value = value;
    r.type = type;
    return r;
}

extern const float FlexAuto;
extern const float FlexUndefined;
extern const float FlexContent;

#define FlexLengthZero      flexLength(0, FlexLengthTypeDefault)
#define FlexLengthAuto      flexLength(FlexAuto, FlexLengthTypeDefault)
#define FlexLengthContent   flexLength(FlexContent, FlexLengthTypeDefault)
#define FlexLengthUndefined flexLength(FlexUndefined, FlexLengthTypeDefault)


#define FLEX_GETTER(type, Name, field) type Flex_get##Name(FlexNodeRef node);
#define FLEX_SETTER(type, Name, field) void Flex_set##Name(FlexNodeRef node, type Name);
#define FLEX_SETTER_LENGTH_VALUE(Name, field, Type) void Flex_set##Name(FlexNodeRef node, float Name);
#define FLEX_SETTER_LENGTH_TYPE(Name, field, Type) void Flex_set##Name##Type(FlexNodeRef node);

FLEX_PROPERTYES()
FLEX_EXT_PROPERTYES()
FLEX_RESULT_PROPERTYES()

#undef FLEX_GETTER
#undef FLEX_SETTER
#undef FLEX_SETTER_LENGTH_VALUE
#undef FLEX_SETTER_LENGTH_TYPE


FlexNodeRef newFlexNode();
void initFlexNode(FlexNodeRef node);
void freeFlexNode(FlexNodeRef node);
void layoutFlexNode(FlexNodeRef node, float constrainedWidth, float constrainedHeight, float scale);

#ifdef __cplusplus
}
#endif
