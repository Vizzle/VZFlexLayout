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

static const float FlexUndefined = -999999;  // used in properties: marginTop, paddingTop, ...
static const float FlexInfinite = -999998;  // used in constraintedSize, maxWidth, maxHeight
static const float FlexAuto = -999997;       // used in properties: flexBasis, width, height, margin, padding, marginTop, ...
static const float FlexContent = -999996;        // used in properties: flexBasis

typedef enum {
    FlexHorizontal,
    FlexVertical,
    FlexHorizontalReverse,
    FlexVerticalReverse
} FlexDirection;

static const FlexDirection FLEX_WIDTH = FlexHorizontal;
static const FlexDirection FLEX_HEIGHT = FlexVertical;

typedef enum {
    FlexInherit,
    FlexStretch,
    FlexStart,
    FlexCenter,
    FlexEnd,
    FlexSpaceBetween,
    FlexSpaceAround
} FlexAlign;

typedef struct {
    float size[2];
} FlexSize;

typedef enum {
    FLEX_LEFT = 0,
    FLEX_TOP,
    FLEX_RIGHT,
    FLEX_BOTTOM,
    FLEX_START,
    FLEX_END
} FlexPositionIndex;

typedef struct {
    float position[2];
    float size[2];
    float margin[4];
} FlexResult;

typedef struct FlexNode {
    bool fixed;
    bool wrap;
    FlexDirection direction;
    FlexAlign alignItems;
    FlexAlign alignSelf;
    FlexAlign alignContent;
    FlexAlign justifyContent;
    float flexBasis;
    float flexGrow;
    float flexShrink;
    float size[2];
    float minSize[2];
    float maxSize[2];
    float margin[6];
    float padding[6];
    float border[6];
    float spacing;
    float lineSpacing;
    
    FlexResult result;
    
    void* context;
    size_t childrenCount;
    FlexSize (*measure)(void* context, FlexSize constraintedSize);
    struct FlexNode* (*childAt)(void* context, size_t index);
} FlexNode;

void initFlexNode(FlexNode* node);
void layoutFlexNode(FlexNode* node, float constraintedWidth, float constraintedHeight);
   
#ifdef __cplusplus
}
#endif
