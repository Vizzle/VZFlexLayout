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
    FlexLengthTypeUndefined,
    FlexLengthTypePoint,
    FlexLengthTypePercent,
    FlexLengthTypeAuto,
    FlexLengthTypeContent,
} FlexLengthType;


typedef struct {
    float value;
    FlexLengthType type;
} FlexLength;


#define FlexUndefined NAN
#define FlexIsUndefined(n) isnan(n)

#define FlexLengthZero      (FlexLength){ 0,   FlexLengthTypePoint     }
#define FlexLengthAuto      (FlexLength){ NAN, FlexLengthTypeAuto      }
#define FlexLengthContent   (FlexLength){ NAN, FlexLengthTypeContent   }
#define FlexLengthUndefined (FlexLength){ NAN, FlexLengthTypeUndefined }


typedef union {
    struct {
        float width;
        float height;
    };
    float size[2];
} FlexSize;


typedef struct FlexNode * FlexNodeRef;

typedef FlexSize    (*FlexMeasureFunc )(void* context, FlexSize constrainedSize);
typedef float       (*FlexBaselineFunc)(void* context, FlexSize constrainedSize);
typedef FlexNodeRef (*FlexChildAtFunc )(void* context, size_t index);


FlexNodeRef Flex_newNode();
void Flex_initNode(FlexNodeRef node);
void Flex_freeNode(FlexNodeRef node);
void Flex_layout  (FlexNodeRef node, float constrainedWidth, float constrainedHeight, float scale);


#define FLEX_GETTER(type, Name, field)                  type Flex_get##Name(FlexNodeRef node);
#define FLEX_SETTER(type, Name, field)                  void Flex_set##Name(FlexNodeRef node, type Name);
#define FLEX_SETTER_LENGTH_VALUE(Name, field, Type)     void Flex_set##Name(FlexNodeRef node, float Name);
#define FLEX_SETTER_LENGTH_TYPE(Name, field, Type)      void Flex_set##Name##Type(FlexNodeRef node);

FLEX_PROPERTYES()
FLEX_EXT_PROPERTYES()
FLEX_RESULT_PROPERTYES()

#undef FLEX_GETTER
#undef FLEX_SETTER
#undef FLEX_SETTER_LENGTH_VALUE
#undef FLEX_SETTER_LENGTH_TYPE


#ifdef __cplusplus
}
#endif
