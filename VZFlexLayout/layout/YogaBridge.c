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
    FlexNodeRef flexNode = YGNodeGetContext(node);
    YGSize ret = {0, 0};
    if (Flex_getMeasureFunc(flexNode)) {
        FlexSize size = {{width, height}};
        FlexSize result = Flex_getMeasureFunc(flexNode)(Flex_getContext(flexNode), size);
        ret.width = result.width;
        ret.height = result.height;
    }
    return ret;
}

float yg_baseline(YGNodeRef node, const float width, const float height) {
    FlexNodeRef flexNode = YGNodeGetContext(node);
    if (Flex_getBaselineFunc(flexNode)) {
        FlexSize size = {{width, height}};
        return Flex_getMeasureFunc(flexNode)(Flex_getContext(flexNode), size).height - Flex_getBaselineFunc(flexNode)(Flex_getContext(flexNode), size);
    }
    return 0;
};

YGNodeRef convertToYogaNode(FlexNodeRef flexNode, YGConfigRef config) {
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
    YGNodeStyleSetFlexDirection(node, flexDirectionMap[Flex_getDirection(flexNode)]);
    YGNodeStyleSetJustifyContent(node, justifyMap[Flex_getJustifyContent(flexNode)]);
    YGNodeStyleSetAlignItems(node, alignMap[Flex_getAlignItems(flexNode)]);
    YGNodeStyleSetAlignSelf(node, alignMap[Flex_getAlignSelf(flexNode)]);
    YGNodeStyleSetAlignContent(node, alignMap[Flex_getAlignContent(flexNode)]);
    YGNodeStyleSetFlexWrap(node, wrapMap[Flex_getWrap(flexNode)]);
    YGNodeStyleSetDisplay(node, YGDisplayFlex);
    YGNodeStyleSetFlexGrow(node, Flex_getFlexGrow(flexNode));
    YGNodeStyleSetFlexShrink(node, Flex_getFlexShrink(flexNode));

#define SET_LENGTH(name) \
    if (Flex_get##name(flexNode).value == FlexUndefined) { \
    } \
    else if (Flex_get##name(flexNode).type == FlexLengthTypePercent) { \
        YGNodeStyleSet##name##Percent(node, Flex_get##name(flexNode).value); \
    } \
    else { \
        YGNodeStyleSet##name(node, flex_absoluteValue(Flex_get##name(flexNode), YGConfigGetContext(config))); \
    }
#define SET_LENGTH_AUTO(name) \
    if (Flex_get##name(flexNode).value == FlexAuto) { \
        YGNodeStyleSet##name##Auto(node); \
    } \
    else SET_LENGTH(name)
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

    SET_LENGTH_AUTO(Width)
    SET_LENGTH_AUTO(Height)
    SET_LENGTH_AUTO(FlexBasis)
    SET_LENGTH(MinWidth)
    SET_LENGTH(MinHeight)
    SET_LENGTH(MaxWidth)
    SET_LENGTH(MaxHeight)
    SET_LENGTH_EDGE(Flex_getPaddingTop(flexNode), Padding, YGEdgeTop)
    SET_LENGTH_EDGE(Flex_getPaddingLeft(flexNode), Padding, YGEdgeLeft)
    SET_LENGTH_EDGE(Flex_getPaddingRight(flexNode), Padding, YGEdgeRight)
    SET_LENGTH_EDGE(Flex_getPaddingBottom(flexNode), Padding, YGEdgeBottom)
    YGNodeStyleSetBorder(node, YGEdgeTop, Flex_getBorderTop(flexNode));
    YGNodeStyleSetBorder(node, YGEdgeLeft, Flex_getBorderLeft(flexNode));
    YGNodeStyleSetBorder(node, YGEdgeRight, Flex_getBorderRight(flexNode));
    YGNodeStyleSetBorder(node, YGEdgeBottom, Flex_getBorderBottom(flexNode));

    SET_LENGTH(Spacing);
    SET_LENGTH(LineSpacing);

    if (Flex_getFixed(flexNode)) {
        YGNodeStyleSetPositionType(node, YGPositionTypeAbsolute);
        if (Flex_getMarginTop(flexNode).value != FlexAuto) {SET_LENGTH_EDGE(Flex_getMarginTop(flexNode), Position, YGEdgeTop)}
        if (Flex_getMarginLeft(flexNode).value != FlexAuto) {SET_LENGTH_EDGE(Flex_getMarginLeft(flexNode), Position, YGEdgeLeft)}
        if (Flex_getMarginRight(flexNode).value != FlexAuto) {SET_LENGTH_EDGE(Flex_getMarginRight(flexNode), Position, YGEdgeRight)}
        if (Flex_getMarginBottom(flexNode).value != FlexAuto) {SET_LENGTH_EDGE(Flex_getMarginBottom(flexNode), Position, YGEdgeBottom)}
    }
    else {
        SET_LENGTH_EDGE_AUTO(Flex_getMarginTop(flexNode), Margin, YGEdgeTop)
        SET_LENGTH_EDGE_AUTO(Flex_getMarginLeft(flexNode), Margin, YGEdgeLeft)
        SET_LENGTH_EDGE_AUTO(Flex_getMarginRight(flexNode), Margin, YGEdgeRight)
        SET_LENGTH_EDGE_AUTO(Flex_getMarginBottom(flexNode), Margin, YGEdgeBottom)
    }

    YGNodeSetContext(node, flexNode);
    if (Flex_getMeasureFunc(flexNode) && Flex_getChildrenCount(flexNode) == 0) {
        YGNodeSetMeasureFunc(node, yg_measure);
    }
    if (Flex_getBaselineFunc(flexNode)) {
        YGNodeSetBaselineFunc(node, yg_baseline);
    }

    for (int i=0;i<Flex_getChildrenCount(flexNode);i++) {
        YGNodeRef childNode = convertToYogaNode(Flex_getChildAtFunc(flexNode)(Flex_getContext(flexNode), i), config);
        YGNodeInsertChild(node, childNode, i);
    }

    return node;
}

#define FLEX_GETTER(type, Name, field) extern void Flex_set##Name(FlexNodeRef node, type Name);
FLEX_RESULT_PROPERTYES()
#undef FLEX_GETTER

void copyLayoutResult(FlexNodeRef flexNode, YGNodeRef node) {
    Flex_setResultLeft(flexNode, YGNodeLayoutGetLeft(node));
    Flex_setResultTop(flexNode, YGNodeLayoutGetTop(node));
    Flex_setResultWidth(flexNode, YGNodeLayoutGetWidth(node));
    Flex_setResultHeight(flexNode, YGNodeLayoutGetHeight(node));
    Flex_setResultMarginLeft(flexNode, YGNodeLayoutGetMargin(node, YGEdgeLeft));
    Flex_setResultMarginTop(flexNode, YGNodeLayoutGetMargin(node, YGEdgeTop));
    Flex_setResultMarginRight(flexNode, YGNodeLayoutGetMargin(node, YGEdgeRight));
    Flex_setResultMarginBottom(flexNode, YGNodeLayoutGetMargin(node, YGEdgeBottom));
    Flex_setResultPaddingLeft(flexNode, YGNodeLayoutGetPadding(node, YGEdgeLeft));
    Flex_setResultPaddingTop(flexNode, YGNodeLayoutGetPadding(node, YGEdgeTop));
    Flex_setResultPaddingRight(flexNode, YGNodeLayoutGetPadding(node, YGEdgeRight));
    Flex_setResultPaddingBottom(flexNode, YGNodeLayoutGetPadding(node, YGEdgeBottom));
    for (int i=0;i<Flex_getChildrenCount(flexNode);i++) {
        copyLayoutResult(Flex_getChildAtFunc(flexNode)(Flex_getContext(flexNode), i), YGNodeGetChild(node, i));
    }
}

void layoutYoga(FlexNodeRef node, float constrainedWidth, float constrainedHeight, float scale) {
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
