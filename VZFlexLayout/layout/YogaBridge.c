//
//  YogaBridge.c
//  Pods
//
//  Created by Sleen on 2017/8/30.
//
//

#include "YogaBridge.h"

#ifdef __cplusplus
extern "C"{
#endif

#include "Yoga.h"


bool USE_YOGA = false;

void setUseYoga(bool useYoga) {
    USE_YOGA = useYoga;
}

bool isUseYoga() {
    return USE_YOGA;
}


typedef struct {
    float viewportWidth;
    float viewportHeight;
    float scale;
} _FlexLayoutContext;

typedef struct FlexLayoutContext* FlexLayoutContextRef;

extern float flex_absoluteValue(FlexLength length, FlexLayoutContextRef context);

YGSize yg_measure(YGNodeRef node,
                  float width,
                  YGMeasureMode widthMode,
                  float height,
                  YGMeasureMode heightMode) {
    FlexNode *flexNode = YGNodeGetContext(node);
    YGSize ret = {0, 0};
    if (flexNode->measure) {
        FlexSize size = {{width, height}};
        FlexSize result = flexNode->measure(flexNode->context, size);
        ret.width = result.size[FLEX_WIDTH];
        ret.height = result.size[FLEX_HEIGHT];
    }
    return ret;
}

float yg_baseline(YGNodeRef node, const float width, const float height) {
    FlexNode *flexNode = YGNodeGetContext(node);
    if (flexNode->baseline) {
        FlexSize size = {{width, height}};
        return flexNode->measure(flexNode->context, size).size[FLEX_HEIGHT] - flexNode->baseline(flexNode->context, size);
    }
    return 0;
};

YGNodeRef convertToYogaNode(FlexNode* flexNode, YGConfigRef config) {
    YGNodeRef node = YGNodeNewWithConfig(config);
    static const YGFlexDirection flexDirectionMap[] = {
        YGFlexDirectionRow,             // FlexHorizontal,
        YGFlexDirectionColumn,          // FlexVertical,
        YGFlexDirectionRowReverse,      // FlexHorizontalReverse,
        YGFlexDirectionColumnReverse,   // FlexVerticalReverse,
    };
    static const YGJustify justifyMap[] = {
        YGJustifyFlexStart,         // FlexInherit,
        YGJustifyFlexStart,         // FlexStretch,
        YGJustifyFlexStart,         // FlexStart,
        YGJustifyCenter,            // FlexCenter,
        YGJustifyFlexEnd,           // FlexEnd,
        YGJustifySpaceBetween,      // FlexSpaceBetween,
        YGJustifySpaceAround,       // FlexSpaceAround,
        YGJustifyFlexStart,         // FlexBaseline,
    };
    static const YGAlign alignMap[] = {
        YGAlignAuto,                // FlexInherit,
        YGAlignStretch,             // FlexStretch,
        YGAlignFlexStart,           // FlexStart,
        YGAlignCenter,              // FlexCenter,
        YGAlignFlexEnd,             // FlexEnd,
        YGAlignSpaceBetween,        // FlexSpaceBetween,
        YGAlignSpaceAround,         // FlexSpaceAround,
        YGAlignBaseline,            // FlexBaseline,
    };
    static const YGWrap wrapMap[] = {
        YGWrapNoWrap,               // FlexNoWrap,
        YGWrapWrap,                 // FlexWrap,
        YGWrapWrapReverse,          // FlexWrapReverse,
    };
    YGNodeStyleSetFlexDirection(node, flexDirectionMap[flexNode->direction]);
    YGNodeStyleSetJustifyContent(node, justifyMap[flexNode->justifyContent]);
    YGNodeStyleSetAlignItems(node, alignMap[flexNode->alignItems]);
    YGNodeStyleSetAlignSelf(node, alignMap[flexNode->alignSelf]);
    YGNodeStyleSetAlignContent(node, alignMap[flexNode->alignContent]);
    YGNodeStyleSetFlexWrap(node, wrapMap[flexNode->wrap]);
    YGNodeStyleSetDisplay(node, YGDisplayFlex);
    YGNodeStyleSetFlexGrow(node, flexNode->flexGrow);
    YGNodeStyleSetFlexShrink(node, flexNode->flexShrink);

#define SET_LENGTH(flex, yoga) \
    if (flex.value == FlexUndefined) { \
    } \
    else if (flex.type == FlexLengthTypePercent) { \
        YGNodeStyleSet##yoga##Percent(node, flex.value); \
    } \
    else { \
        YGNodeStyleSet##yoga(node, flex_absoluteValue(flex, YGConfigGetContext(config))); \
    }
#define SET_LENGTH_AUTO(flex, yoga) \
    if (flex.value == FlexAuto) { \
        YGNodeStyleSet##yoga##Auto(node); \
    } \
    else SET_LENGTH(flex, yoga)
#define SET_LENGTH_EDGE(flex, yoga, edge) \
    if (flex.value == FlexUndefined) { \
    } \
    else if (flex.type == FlexLengthTypePercent) { \
        YGNodeStyleSet##yoga##Percent(node, edge, flex.value); \
    } \
    else { \
        YGNodeStyleSet##yoga(node, edge, flex_absoluteValue(flex, YGConfigGetContext(config))); \
    }
#define SET_LENGTH_EDGE_AUTO(flex, yoga, edge) \
    if (flex.value == FlexAuto) { \
        YGNodeStyleSet##yoga##Auto(node, edge); \
    } \
    else SET_LENGTH_EDGE(flex, yoga, edge)

    SET_LENGTH_AUTO(flexNode->size[FLEX_WIDTH], Width)
    SET_LENGTH_AUTO(flexNode->size[FLEX_HEIGHT], Height)
    SET_LENGTH_AUTO(flexNode->flexBasis, FlexBasis)
    SET_LENGTH(flexNode->minSize[FLEX_WIDTH], MinWidth)
    SET_LENGTH(flexNode->minSize[FLEX_HEIGHT], MinHeight)
    SET_LENGTH(flexNode->maxSize[FLEX_WIDTH], MaxWidth)
    SET_LENGTH(flexNode->maxSize[FLEX_HEIGHT], MaxHeight)
    SET_LENGTH_EDGE(flexNode->padding[FLEX_TOP], Padding, YGEdgeTop)
    SET_LENGTH_EDGE(flexNode->padding[FLEX_LEFT], Padding, YGEdgeLeft)
    SET_LENGTH_EDGE(flexNode->padding[FLEX_RIGHT], Padding, YGEdgeRight)
    SET_LENGTH_EDGE(flexNode->padding[FLEX_BOTTOM], Padding, YGEdgeBottom)
    YGNodeStyleSetBorder(node, YGEdgeTop, flexNode->border[FLEX_TOP].value);
    YGNodeStyleSetBorder(node, YGEdgeLeft, flexNode->border[FLEX_LEFT].value);
    YGNodeStyleSetBorder(node, YGEdgeRight, flexNode->border[FLEX_RIGHT].value);
    YGNodeStyleSetBorder(node, YGEdgeBottom, flexNode->border[FLEX_BOTTOM].value);

    SET_LENGTH(flexNode->spacing, Spacing);
    SET_LENGTH(flexNode->lineSpacing, LineSpacing);

    if (flexNode->fixed) {
        YGNodeStyleSetPositionType(node, YGPositionTypeAbsolute);
        if (flexNode->margin[FLEX_TOP].value != FlexAuto) {SET_LENGTH_EDGE(flexNode->margin[FLEX_TOP], Position, YGEdgeTop)}
        if (flexNode->margin[FLEX_LEFT].value != FlexAuto) {SET_LENGTH_EDGE(flexNode->margin[FLEX_LEFT], Position, YGEdgeLeft)}
        if (flexNode->margin[FLEX_RIGHT].value != FlexAuto) {SET_LENGTH_EDGE(flexNode->margin[FLEX_RIGHT], Position, YGEdgeRight)}
        if (flexNode->margin[FLEX_BOTTOM].value != FlexAuto) {SET_LENGTH_EDGE(flexNode->margin[FLEX_BOTTOM], Position, YGEdgeBottom)}
    }
    else {
        SET_LENGTH_EDGE_AUTO(flexNode->margin[FLEX_TOP], Margin, YGEdgeTop)
        SET_LENGTH_EDGE_AUTO(flexNode->margin[FLEX_LEFT], Margin, YGEdgeLeft)
        SET_LENGTH_EDGE_AUTO(flexNode->margin[FLEX_RIGHT], Margin, YGEdgeRight)
        SET_LENGTH_EDGE_AUTO(flexNode->margin[FLEX_BOTTOM], Margin, YGEdgeBottom)
    }

    YGNodeSetContext(node, flexNode);
    if (flexNode->measure && flexNode->childrenCount == 0) {
        YGNodeSetMeasureFunc(node, yg_measure);
    }
    if (flexNode->baseline) {
        YGNodeSetBaselineFunc(node, yg_baseline);
    }

    for (int i=0;i<flexNode->childrenCount;i++) {
        YGNodeRef childNode = convertToYogaNode(flexNode->childAt(flexNode->context, i), config);
        YGNodeInsertChild(node, childNode, i);
    }

    return node;
}

void copyLayoutResult(FlexNode* flexNode, YGNodeRef node) {
    flexNode->result.size[FLEX_WIDTH] = YGNodeLayoutGetWidth(node);
    flexNode->result.size[FLEX_HEIGHT] = YGNodeLayoutGetHeight(node);
    flexNode->result.position[FLEX_LEFT] = YGNodeLayoutGetLeft(node);
    flexNode->result.position[FLEX_TOP] = YGNodeLayoutGetTop(node);
    flexNode->result.margin[FLEX_LEFT] = YGNodeLayoutGetMargin(node, YGEdgeLeft);
    flexNode->result.margin[FLEX_TOP] = YGNodeLayoutGetMargin(node, YGEdgeTop);
    flexNode->result.margin[FLEX_RIGHT] = YGNodeLayoutGetMargin(node, YGEdgeRight);
    flexNode->result.margin[FLEX_BOTTOM] = YGNodeLayoutGetMargin(node, YGEdgeBottom);
    flexNode->result.border[FLEX_LEFT] = YGNodeLayoutGetBorder(node, YGEdgeLeft);
    flexNode->result.border[FLEX_TOP] = YGNodeLayoutGetBorder(node, YGEdgeTop);
    flexNode->result.border[FLEX_RIGHT] = YGNodeLayoutGetBorder(node, YGEdgeRight);
    flexNode->result.border[FLEX_BOTTOM] = YGNodeLayoutGetBorder(node, YGEdgeBottom);
    flexNode->resolvedPadding[FLEX_LEFT] = YGNodeLayoutGetPadding(node, YGEdgeLeft);
    flexNode->resolvedPadding[FLEX_TOP] = YGNodeLayoutGetPadding(node, YGEdgeTop);
    flexNode->resolvedPadding[FLEX_RIGHT] = YGNodeLayoutGetPadding(node, YGEdgeRight);
    flexNode->resolvedPadding[FLEX_BOTTOM] = YGNodeLayoutGetPadding(node, YGEdgeBottom);
    for (int i=0;i<flexNode->childrenCount;i++) {
        copyLayoutResult(flexNode->childAt(flexNode->context, i), YGNodeGetChild(node, i));
    }
}

void layoutYoga(FlexNode* node, float constrainedWidth, float constrainedHeight, float scale) {
    if (constrainedWidth == FlexAuto || constrainedWidth == FlexUndefined) {
        constrainedWidth = YGUndefined;
    }
    if (constrainedHeight == FlexAuto || constrainedHeight == FlexUndefined) {
        constrainedHeight = YGUndefined;
    }

    _FlexLayoutContext context;
    context.viewportWidth = constrainedWidth != FlexAuto ? constrainedWidth : 0;
    context.viewportHeight = constrainedHeight != FlexAuto ? constrainedHeight : 0;
    context.scale = scale;

    YGConfigRef config = YGConfigNew();
    YGConfigSetPointScaleFactor(config, scale);
    YGConfigSetContext(config, &context);
    YGNodeRef yogaNode = convertToYogaNode(node, config);
    
    YGNodeCalculateLayout(yogaNode, constrainedWidth, constrainedHeight, YGDirectionLTR);
    copyLayoutResult(node, yogaNode);

    YGNodeFreeRecursive(yogaNode);
    YGConfigFree(config);
}

#ifdef __cplusplus
}
#endif
