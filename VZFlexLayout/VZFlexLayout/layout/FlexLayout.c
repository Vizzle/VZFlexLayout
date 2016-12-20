//
//  FlexLayout.m
//  flex_layout
//
//  Created by Sleen on 16/1/25.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#include "FlexLayout.h"
#include "khash.h"

#include <stdlib.h>
#include <assert.h>
#include <float.h>
#include <math.h>

#define kh_FlexSize_hash_func(key) (uint32_t)((uint32_t)(key.size[FLEX_WIDTH]) ^ (uint32_t)(key.size[FLEX_HEIGHT]))
#define kh_FlexSize_hash_equal(a, b) (a.size[FLEX_WIDTH] == b.size[FLEX_WIDTH] && a.size[FLEX_HEIGHT] == b.size[FLEX_HEIGHT])

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
KHASH_INIT(FlexSize, FlexSize, FlexSize, 1, kh_FlexSize_hash_func, kh_FlexSize_hash_equal)
#pragma GCC diagnostic pop


#define FLEX_PIXEL_ROUND(value, scale) (roundf((value) * (scale)) / (scale))



 const float FlexUndefined = 999999;
 const float FlexAuto = 999998;

typedef struct {
    float viewportWidth;
    float viewportHeight;
    float scale;
} FlexLayoutContext;

FlexSize flex_size(float width, float height) {
    FlexSize size;
    size.size[FLEX_WIDTH] = width;
    size.size[FLEX_HEIGHT] = height;
    return size;
}

bool flex_isAbsolute(FlexLength length) {
    return length.type != FlexLengthTypePercent && length.value != FlexAuto && length.value != FlexUndefined;
}

float flex_absoluteValue(FlexLength length, FlexLayoutContext *context) {
    assert(flex_isAbsolute(length));    // absolute value is requested
    
    float value;
    switch (length.type) {
        case FlexLengthTypeDefault:
            value = length.value;
            break;
        case FlexLengthTypePx:
            value = length.value / context->scale;
            break;
        case FlexLengthTypeCm:
            value = length.value * 96 / 2.54;
            break;
        case FlexLengthTypeMm:
            value = length.value * 96 / 2.54 / 10;
            break;
        case FlexLengthTypeQ:
            value = length.value * 96 / 2.54 / 40;
            break;
        case FlexLengthTypeIn:
            value = length.value * 96;
            break;
        case FlexLengthTypePc:
            value = length.value * 96 / 6;
            break;
        case FlexLengthTypePt:
            value = length.value * 96 / 72;
            break;
//            case FlexLengthTypeEm:
//            case FlexLengthTypeEx:
//            case FlexLengthTypeCh:
//            case FlexLengthTypeRem:
        case FlexLengthTypeVw:
            value = length.value / 100 * context->viewportWidth;
            break;
        case FlexLengthTypeVh:
            value = length.value / 100 * context->viewportHeight;
            break;
        case FlexLengthTypeVmin:
            value = length.value / 100 * fminf(context->viewportWidth, context->viewportHeight);
            break;
        case FlexLengthTypeVmax:
            value = length.value / 100 * fmaxf(context->viewportWidth, context->viewportHeight);
            break;
        default:
            value = length.value;
            break;
    }
    
    return value;
}

float flex_resolve(FlexLength length, FlexLayoutContext *context, float relativeTo) {
    if (flex_isAbsolute(length)) {
        return flex_absoluteValue(length, context);
    }
    else if (length.type == FlexLengthTypePercent && relativeTo != FlexAuto) {
        return length.value / 100 * relativeTo;
    }
    
    return FlexAuto;
}

float clamp(float value, float minValue, float maxValue) {
    if (maxValue == FlexAuto || maxValue == FlexUndefined) {
        return fmaxf(value, minValue);
    } else {
        return fmaxf(fminf(value, maxValue), minValue);
    }
}

float clampMax(float value, float maxValue) {
    if (maxValue == FlexAuto || maxValue == FlexUndefined) {
        return value;
    } else {
        return fminf(value, maxValue);
    }
}

static FlexPositionIndex flex_start[4] = { FLEX_LEFT, FLEX_TOP, FLEX_RIGHT, FLEX_BOTTOM };
static FlexPositionIndex flex_end[4] = { FLEX_RIGHT, FLEX_BOTTOM, FLEX_LEFT, FLEX_TOP };
static FlexDirection flex_dim[4] = { FLEX_WIDTH, FLEX_HEIGHT, FLEX_WIDTH, FLEX_HEIGHT };

void flex_resolveMarginAndPadding(FlexNode *node, FlexLayoutContext *context, float widthOfContainingBlock, FlexDirection parentDirection) {
    bool isMainHorizontal = parentDirection == FlexHorizontal || parentDirection == FlexHorizontalReverse;
    FlexDirection crossAxis = isMainHorizontal ? FlexVertical : FlexHorizontal;
    node->resolvedMargin[flex_start[parentDirection]] = flex_resolve(!node->fixed && isMainHorizontal && node->margin[FLEX_START].value != FlexUndefined ? node->margin[FLEX_START] : node->margin[flex_start[parentDirection]], context, widthOfContainingBlock);
    node->resolvedMargin[flex_end[parentDirection]] = flex_resolve(!node->fixed && isMainHorizontal && node->margin[FLEX_END].value != FlexUndefined ? node->margin[FLEX_END] : node->margin[flex_end[parentDirection]], context, widthOfContainingBlock);
    node->resolvedMargin[flex_start[crossAxis]] = flex_resolve(!node->fixed && !isMainHorizontal && node->margin[FLEX_START].value != FlexUndefined ? node->margin[FLEX_START] : node->margin[flex_start[crossAxis]], context, widthOfContainingBlock);
    node->resolvedMargin[flex_end[crossAxis]] = flex_resolve(!node->fixed && !isMainHorizontal && node->margin[FLEX_END].value != FlexUndefined ? node->margin[FLEX_END] : node->margin[flex_end[crossAxis]], context, widthOfContainingBlock);
    node->result.border[flex_start[parentDirection]] = flex_resolve(isMainHorizontal && node->border[FLEX_START].value != FlexUndefined ? node->border[FLEX_START] : node->border[flex_start[parentDirection]], context, 0);
    node->result.border[flex_end[parentDirection]] = flex_resolve(isMainHorizontal && node->border[FLEX_END].value != FlexUndefined ? node->border[FLEX_END] : node->border[flex_end[parentDirection]], context, 0);
    node->result.border[flex_start[crossAxis]] = flex_resolve(!isMainHorizontal && node->border[FLEX_START].value != FlexUndefined ? node->border[FLEX_START] : node->border[flex_start[crossAxis]], context, 0);
    node->result.border[flex_end[crossAxis]] = flex_resolve(!isMainHorizontal && node->border[FLEX_END].value != FlexUndefined ? node->border[FLEX_END] : node->border[flex_end[crossAxis]], context, 0);
    node->resolvedPadding[flex_start[parentDirection]] = flex_resolve(isMainHorizontal && node->padding[FLEX_START].value != FlexUndefined ? node->padding[FLEX_START] : node->padding[flex_start[parentDirection]], context, widthOfContainingBlock) + node->result.border[flex_start[parentDirection]];
    node->resolvedPadding[flex_end[parentDirection]] = flex_resolve(isMainHorizontal && node->padding[FLEX_END].value != FlexUndefined ? node->padding[FLEX_END] : node->padding[flex_end[parentDirection]], context, widthOfContainingBlock) + node->result.border[flex_end[parentDirection]];
    node->resolvedPadding[flex_start[crossAxis]] = flex_resolve(!isMainHorizontal && node->padding[FLEX_START].value != FlexUndefined ? node->padding[FLEX_START] : node->padding[flex_start[crossAxis]], context, widthOfContainingBlock) + node->result.border[flex_start[crossAxis]];
    node->resolvedPadding[flex_end[crossAxis]] = flex_resolve(!isMainHorizontal && node->padding[FLEX_END].value != FlexUndefined ? node->padding[FLEX_END] : node->padding[flex_end[crossAxis]], context, widthOfContainingBlock) + node->result.border[flex_end[crossAxis]];
    node->result.margin[0] = node->resolvedMargin[0];
    node->result.margin[1] = node->resolvedMargin[1];
    node->result.margin[2] = node->resolvedMargin[2];
    node->result.margin[3] = node->resolvedMargin[3];
}

float flex_inset(float *inset, FlexDirection direction) {
    float inset_start = inset[flex_start[direction]];
    float inset_end = inset[flex_end[direction]];
    return (inset_start != FlexAuto ? inset_start : 0) + (inset_end != FlexAuto ? inset_end : 0);
}

void flex_baseline(FlexNode *node, float *ascender, float *descender) {
    FlexDirection crossAxis = FlexVertical;
    float _ascender, _descender;
    
    if (node->ascender != FlexUndefined) {
        _ascender = node->ascender;
        _descender = node->result.size[crossAxis] - _ascender;
    }
    else if (node->baseline) {
        FlexSize size;
        size.size[FLEX_WIDTH] = node->result.size[FLEX_WIDTH] - flex_inset(node->resolvedPadding, FLEX_WIDTH);
        size.size[FLEX_HEIGHT] = node->result.size[FLEX_HEIGHT] - flex_inset(node->resolvedPadding, FLEX_HEIGHT);
        _descender = node->baseline(node->context, size) + node->resolvedPadding[flex_end[crossAxis]];
        _ascender = node->result.size[crossAxis] - _descender;
    }
    else {
        _ascender = node->result.size[crossAxis];
        for (int i=0;i<node->childrenCount;i++) {
            FlexNode *child = node->childAt(node->context, i);
            if (!child->fixed) {
                flex_baseline(child, NULL, NULL);
                _ascender = child->ascender + (isnan(child->result.position[flex_start[crossAxis]]) ? 0 : child->result.position[flex_start[crossAxis]]);
                break;
            }
        }
        _descender = node->result.size[crossAxis] - _ascender;
    }
    
    node->ascender = _ascender;
    _ascender += node->resolvedMargin[flex_start[crossAxis]] == FlexAuto ? 0 : node->resolvedMargin[flex_start[crossAxis]];
    _descender += node->resolvedMargin[flex_end[crossAxis]] == FlexAuto ? 0 : node->resolvedMargin[flex_end[crossAxis]];
    
    if (ascender) *ascender = _ascender;
    if (descender) *descender = _descender;
}

bool hasAutoMargin(FlexNode* node, FlexDirection direction) {
    return node->resolvedMargin[flex_start[direction]] == FlexAuto || node->resolvedMargin[flex_end[direction]] == FlexAuto;
}

typedef enum {
    FlexLayoutFlagMeasureWidth = 1 << 0,    // only measure width
    FlexLayoutFlagMeasureHeight = 1 << 1,   // only measure height
    FlexLayoutFlagLayout = 1 << 2,          // measure and layout
} FlexLayoutFlags;

typedef struct {
    float itemsSize;
    int itemsCount;
    float ascender;
} FlexLine;

void _layoutFlexNode(FlexNode* node, FlexLayoutContext *context, FlexSize constrainedSize, FlexLayoutFlags flags, bool isRoot) {
    node->ascender = FlexUndefined;
    
    if (constrainedSize.size[FLEX_WIDTH] < 0) constrainedSize.size[FLEX_WIDTH] = 0;
    if (constrainedSize.size[FLEX_HEIGHT] < 0) constrainedSize.size[FLEX_HEIGHT] = 0;
    float constrainedWidth = constrainedSize.size[FLEX_WIDTH];
    float constrainedHeight = constrainedSize.size[FLEX_HEIGHT];
    float resolvedWidth = flex_resolve(node->size[FLEX_WIDTH], context, constrainedWidth);
    float resolvedHeight = flex_resolve(node->size[FLEX_HEIGHT], context, constrainedHeight);
    if (isRoot && resolvedWidth == FlexAuto && constrainedWidth != FlexAuto) resolvedWidth = constrainedWidth;
    if (isRoot && resolvedHeight == FlexAuto && constrainedHeight != FlexAuto) resolvedHeight = constrainedHeight;
    FlexSize resolvedSize = flex_size(resolvedWidth, resolvedHeight);
    FlexSize resolvedInnerSize = flex_size(resolvedWidth == FlexAuto ? FlexAuto : resolvedWidth - flex_inset(node->resolvedPadding, FLEX_WIDTH), 
                                           resolvedHeight == FlexAuto ? FlexAuto : resolvedHeight - flex_inset(node->resolvedPadding, FLEX_HEIGHT));
    
    if (resolvedWidth != FlexAuto) node->result.size[FLEX_WIDTH] = resolvedWidth;
    if (resolvedHeight != FlexAuto) node->result.size[FLEX_HEIGHT] = resolvedHeight;
    
    if (flags == FlexLayoutFlagMeasureWidth && resolvedWidth != FlexAuto) {
        node->result.size[FLEX_WIDTH] = resolvedWidth;
        return;
    }
    if (flags == FlexLayoutFlagMeasureHeight && resolvedHeight != FlexAuto) {
        node->result.size[FLEX_HEIGHT] = resolvedHeight;
        return;
    }
    
    // measure non-container element
    if (node->childrenCount == 0) {
        if (resolvedWidth == FlexAuto || resolvedHeight == FlexAuto) {
            FlexSize measuredSize;
            if (node->measure) {
                FlexSize childConstrainedSize;
                childConstrainedSize.size[FLEX_WIDTH] = resolvedWidth != FlexAuto ? resolvedWidth : (constrainedWidth != FlexAuto ? constrainedWidth - flex_inset(node->resolvedPadding, FLEX_WIDTH) : FLT_MAX);
                childConstrainedSize.size[FLEX_HEIGHT] = resolvedHeight != FlexAuto ? resolvedHeight : (constrainedHeight != FlexAuto ? constrainedHeight - flex_inset(node->resolvedPadding, FLEX_HEIGHT) : FLT_MAX);
                
                khiter_t itr = kh_get(FlexSize, node->measuredSizeCache, childConstrainedSize);
                if (itr != kh_end((khash_t(FlexSize)*)node->measuredSizeCache) && kh_exist((khash_t(FlexSize)*)node->measuredSizeCache, itr)) {
                    measuredSize = kh_value((khash_t(FlexSize)*)node->measuredSizeCache, itr);
                }
                else {
                    measuredSize = node->measure(node->context, childConstrainedSize);
                    int ret;
                    khiter_t itr = kh_put(FlexSize, node->measuredSizeCache, childConstrainedSize, &ret);
                    if (ret) {
                        kh_value((khash_t(FlexSize)*)node->measuredSizeCache, itr) = measuredSize;
                    }
                }
            }
            else {
                measuredSize.size[FLEX_WIDTH] = 0;
                measuredSize.size[FLEX_HEIGHT] = 0;
            }
            
            if (resolvedWidth == FlexAuto) {
                node->result.size[FLEX_WIDTH] = clamp(measuredSize.size[FLEX_WIDTH] + flex_inset(node->resolvedPadding, FLEX_WIDTH), flex_resolve(node->minSize[FLEX_WIDTH], context, constrainedWidth), flex_resolve(node->maxSize[FLEX_WIDTH], context, constrainedWidth));
            }
            if (resolvedHeight == FlexAuto) {
                node->result.size[FLEX_HEIGHT] = clamp(measuredSize.size[FLEX_HEIGHT] + flex_inset(node->resolvedPadding, FLEX_HEIGHT), flex_resolve(node->minSize[FLEX_HEIGHT], context, constrainedHeight), flex_resolve(node->maxSize[FLEX_HEIGHT], context, constrainedHeight));
            }
        }
        
        return;
    }
    
    // layout flex container
    
    bool isReverse = node->direction == FlexHorizontalReverse || node->direction == FlexVerticalReverse;
    FlexDirection mainAxis = flex_dim[node->direction];
    FlexDirection crossAxis = mainAxis == FlexHorizontal ? FlexVertical : FlexHorizontal;
    
    int i, j;
    
    //  [flex items ----------->|<----------- fixed items]
    FlexNode** items = (FlexNode**)malloc(sizeof(FlexNode) * node->childrenCount);
    int flexItemsCount = 0;
    int fixedItemsCount = 0;
    
    for (i=0;i<node->childrenCount;i++) {
        FlexNode* item = node->childAt(node->context, i);
        // resolve margin and padding for each items
        flex_resolveMarginAndPadding(item, context, resolvedInnerSize.size[FLEX_WIDTH], node->direction);
        if (item->fixed) {
            items[node->childrenCount - ++fixedItemsCount] = item;
        }
        else {
            items[flexItemsCount++] = item;
        }
    }
    
    // reference: http://www.w3.org/TR/css3-flexbox/#layout-algorithm
    
    ///////////////////////////////////////////////////////////////////////////
    //  Line Length Determination
    
    // 2. Determine the available main and cross space for the flex items. For each dimension, if that dimension of the flex container’s content box is a definite size, use that; otherwise, subtract the flex container’s margin, border, and padding from the space available to the flex container in that dimension and use that value. This might result in an infinite value.
    
    float resolvedMinCrossSize = flex_resolve(node->minSize[crossAxis], context, constrainedSize.size[crossAxis]);
    float resolvedMaxCrossSize = flex_resolve(node->maxSize[crossAxis], context, constrainedSize.size[crossAxis]);
    float resolvedMarginWidth = flex_inset(node->resolvedMargin, FLEX_WIDTH);
    float resolvedMarginHeight = flex_inset(node->resolvedMargin, FLEX_HEIGHT);
    FlexSize resolvedMarginSize = flex_size(resolvedMarginWidth, resolvedMarginHeight);
    float resolvedPaddingWidth = flex_inset(node->resolvedPadding, FLEX_WIDTH);
    float resolvedPaddingHeight = flex_inset(node->resolvedPadding, FLEX_HEIGHT);
    FlexSize resolvedPaddingSize = flex_size(resolvedPaddingWidth, resolvedPaddingHeight);
    FlexSize availableSize;
    availableSize.size[FLEX_WIDTH] =  resolvedWidth != FlexAuto ? resolvedWidth - resolvedPaddingWidth : constrainedWidth == FlexAuto ? FlexAuto : (constrainedWidth - resolvedMarginWidth - resolvedPaddingWidth);
    availableSize.size[FLEX_HEIGHT] =  resolvedHeight != FlexAuto ? resolvedHeight - resolvedPaddingHeight : constrainedHeight == FlexAuto ? FlexAuto : (constrainedHeight - resolvedMarginHeight - resolvedPaddingHeight);
    
    FlexLine* lines = malloc(sizeof(FlexLine) * flexItemsCount);
    lines[0].itemsCount = 0;
    lines[0].itemsSize = 0;
    int linesCount = 1;
    
    float spacing = flex_resolve(node->spacing, context, resolvedInnerSize.size[mainAxis]);
    float lineSpacing = flex_resolve(node->lineSpacing, context, resolvedInnerSize.size[crossAxis]);
    
    // 3. Determine the flex base size and hypothetical main size of each item:
    for (i=0;i<flexItemsCount;i++) {
        FlexNode* item = items[i];
        
        float itemHypotheticalMainSize;
        float resolvedFlexBasis = flex_resolve(item->flexBasis, context, resolvedInnerSize.size[mainAxis]);
        
        // A. If the item has a definite used flex basis, that’s the flex base size.
        if (resolvedFlexBasis != FlexAuto) {
            item->flexBaseSize = resolvedFlexBasis;
        }
        
        // B. If the flex item has ...
        //      * an intrinsic aspect ratio,
        //      * a used flex basis of content, and
        //      * a definite cross size
        //    then the flex base size is calculated from its inner cross size and the flex item’s intrinsic aspect ratio.
        // TODO supports aspect ratio ?
        
        // E. Otherwise, size the item into the available space using its used flex basis in place of its main size, treating a value of content as max-content. If a cross size is needed to determine the main size (e.g. when the flex item’s main size is in its block axis) and the flex item’s cross size is auto and not definite, in this calculation use fit-content as the flex item’s cross size. The flex base size is the item’s resulting main size.
        else {
            FlexLength oldMainSize = item->size[mainAxis];
            item->size[mainAxis] = item->flexBasis;
//            _layoutFlexNode(item, context, availableSize, mainAxis == FlexHorizontal ? FlexLayoutFlagMeasureWidth : FlexLayoutFlagMeasureHeight, false);
            _layoutFlexNode(item, context, availableSize, flags, false);
            item->size[mainAxis] = oldMainSize;
            item->flexBaseSize = item->result.size[mainAxis];
        }
        
        // When determining the flex base size, the item’s min and max main size properties are ignored (no clamping occurs).
        // The hypothetical main size is the item’s flex base size clamped according to its min and max main size properties.
        itemHypotheticalMainSize = clamp(item->flexBaseSize, flex_resolve(item->minSize[mainAxis], context, resolvedInnerSize.size[mainAxis]), flex_resolve(item->maxSize[mainAxis], context, resolvedInnerSize.size[mainAxis]));
        item->result.size[mainAxis] = itemHypotheticalMainSize;
        float outerItemHypotheticalMainSize = itemHypotheticalMainSize + flex_inset(item->resolvedMargin, mainAxis);
        
        ///////////////////////////////////////////////////////////////////////////
        //  Main Size Determination
        
        // 5. Collect flex items into flex lines:
        //     * If the flex container is single-line, collect all the flex items into a single flex line.
        if (!node->wrap) {
            if (lines[linesCount - 1].itemsCount > 0) lines[linesCount - 1].itemsSize += spacing;
            lines[linesCount - 1].itemsSize += outerItemHypotheticalMainSize;
            lines[linesCount - 1].itemsCount++;
        }
        //     * Otherwise, starting from the first uncollected item, collect consecutive items one by one until the first time that the next collected item would not fit into the flex container’s inner main size (or until a forced break is encountered, see §10 Fragmenting Flex Layout). If the very first uncollected item wouldn’t fit, collect just it into the line.
        /* line break not supported yet */
        //       For this step, the size of a flex item is its outer hypothetical main size.
        //       Repeat until all flex items have been collected into flex lines.
        //       > Note that the "collect as many" line will collect zero-sized flex items onto the end of the previous line even if the last non-zero item exactly "filled up" the line.
        else {
            if (lines[linesCount - 1].itemsCount > 0) outerItemHypotheticalMainSize += spacing;
            if (lines[linesCount - 1].itemsSize + outerItemHypotheticalMainSize > availableSize.size[mainAxis]) {
                if (lines[linesCount - 1].itemsCount == 0) {
                    lines[linesCount - 1].itemsCount = 1;
                    lines[linesCount - 1].itemsSize = outerItemHypotheticalMainSize;
                }
                else {
                    if (lines[linesCount - 1].itemsCount > 0) outerItemHypotheticalMainSize -= spacing;
                    lines[linesCount].itemsCount = 1;
                    lines[linesCount].itemsSize = outerItemHypotheticalMainSize;
                    linesCount++;
                }
            }
            else {
                lines[linesCount - 1].itemsCount++;
                lines[linesCount - 1].itemsSize += outerItemHypotheticalMainSize;
            }
        }
    }
    
    assert(node->wrap || linesCount == 1);
    
    float itemsMainSize = 0;
    for (i=0;i<linesCount;i++) {
        if (lines[i].itemsSize > itemsMainSize) {
            // lineSize means the item's main size, and it will be used to store the lines' cross size below
            itemsMainSize = lines[i].itemsSize;
        }
    }
    
    // 4. Determine the main size of the flex container using the rules of the formatting context in which it participates. For this computation, auto margins on flex items are treated as 0.
    node->result.size[mainAxis] = resolvedSize.size[mainAxis] != FlexAuto ? resolvedSize.size[mainAxis] : clampMax(itemsMainSize + resolvedPaddingSize.size[mainAxis], constrainedSize.size[mainAxis] != FlexAuto ? constrainedSize.size[mainAxis] - resolvedMarginSize.size[mainAxis] : FlexAuto);
    
    if ((flags == FlexLayoutFlagMeasureWidth && mainAxis == FLEX_WIDTH)
        || (flags == FlexLayoutFlagMeasureHeight && mainAxis == FLEX_HEIGHT)) {
        free(lines);
        free(items);
        return;
    }
    
    float innerMainSize = node->result.size[mainAxis] - resolvedPaddingSize.size[mainAxis];
    
    // 6. Resolve the flexible lengths of all the flex items to find their used main size (see section 9.7.).
    bool* isFrozen = malloc(sizeof(bool) * flexItemsCount);
    char* violations = malloc(sizeof(char) * flexItemsCount);
    int lineStart = 0;
    for (i=0;i<linesCount;i++) {
        int count = lines[i].itemsCount;
        int unfrozenCount = count;
        int lineEnd = lineStart + count;
        
        // 6.1 Determine the used flex factor. Sum the outer hypothetical main sizes of all items on the line. If the sum is less than the flex container’s inner main size, use the flex grow factor for the rest of this algorithm; otherwise, use the flex shrink factor.
        float lineMainSize = 0;
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            lineMainSize += item->result.size[mainAxis] + flex_inset(item->resolvedMargin, mainAxis);
        }
        float itemsSpacing = (count - 1) * spacing;
        lineMainSize += itemsSpacing;
        bool usingFlexGrowFactor = lineMainSize < availableSize.size[mainAxis];
        float initialFreeSpace = innerMainSize - itemsSpacing;
        
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            // 6.2 Size inflexible items. Freeze, setting its target main size to its hypothetical main size…
            //       * any item that has a flex factor of zero
            //       * if using the flex grow factor: any item that has a flex base size greater than its hypothetical main size
            //       * if using the flex shrink factor: any item that has a flex base size smaller than its hypothetical main size
            // 6.3 Calculate initial free space. Sum the outer sizes of all items on the line, and subtract this from the flex container’s inner main size. For frozen items, use their outer target main size; for other items, use their outer flex base size.
            if ((usingFlexGrowFactor ? item->flexGrow : item->flexShrink * item->flexBaseSize) == 0
                || (usingFlexGrowFactor && item->flexBaseSize > item->result.size[mainAxis])
                || (!usingFlexGrowFactor && item->flexBaseSize < item->result.size[mainAxis])) {
                isFrozen[j] = true;
                unfrozenCount--;
                initialFreeSpace -= item->result.size[mainAxis] + flex_inset(item->resolvedMargin, mainAxis);
            } else {
                isFrozen[j] = false;
                initialFreeSpace -= item->flexBaseSize + flex_inset(item->resolvedMargin, mainAxis);
            }
        }
        
        // 6.4 Loop:
        while (true) {
            // a. Check for flexible items. If all the flex items on the line are frozen, free space has been distributed; exit this loop.
            if (unfrozenCount == 0) {
                break;
            }
            
            // b. Calculate the remaining free space as for initial free space, above. If the sum of the unfrozen flex items’ flex factors is less than one, multiply the initial free space by this sum. If the magnitude of this value is less than the magnitude of the remaining free space, use this as the remaining free space.
            float remainingFreeSpace = fmax(0.f, innerMainSize - itemsSpacing);
            float unFrozenFlexFactors = 0;
            
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = items[j];
                if (isFrozen[j]) {
                    remainingFreeSpace -= item->result.size[mainAxis] + flex_inset(item->resolvedMargin, mainAxis);
                }
                else {
                    remainingFreeSpace -= item->flexBaseSize + flex_inset(item->resolvedMargin, mainAxis);
                    unFrozenFlexFactors += usingFlexGrowFactor ? item->flexGrow : item->flexShrink;
                }
            }
            
            if (unFrozenFlexFactors < 1) {
                float value = initialFreeSpace * unFrozenFlexFactors;
                if (value < remainingFreeSpace) {
                    remainingFreeSpace = value;
                }
            }
            
            // c. Distribute free space proportional to the flex factors.
            //    If the remaining free space is zero
            //         Do nothing.
            if (remainingFreeSpace == 0) {
                
            }
            //    If using the flex grow factor
            //         Find the ratio of the item’s flex grow factor to the sum of the flex grow factors of all unfrozen items on the line. Set the item’s target main size to its flex base size plus a fraction of the remaining free space proportional to the ratio.
            else if (usingFlexGrowFactor && unFrozenFlexFactors > 0) {
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = items[j];
                    if (!isFrozen[j]) {
                        float ratio = item->flexGrow / unFrozenFlexFactors;
                        item->result.size[mainAxis] = item->flexBaseSize + remainingFreeSpace * ratio;
                    }
                }
            }
            //    If using the flex shrink factor
            //         For every unfrozen item on the line, multiply its flex shrink factor by its inner flex base size, and note this as its scaled flex shrink factor. Find the ratio of the item’s scaled flex shrink factor to the sum of the scaled flex shrink factors of all unfrozen items on the line. Set the item’s target main size to its flex base size minus a fraction of the absolute value of the remaining free space proportional to the ratio. Note this may result in a negative inner main size; it will be corrected in the next step.
            else if (!usingFlexGrowFactor && unFrozenFlexFactors > 0) {
                float unFrozenScaledFlexFactors = 0;
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = items[j];
                    if (!isFrozen[j]) {
                        unFrozenScaledFlexFactors += item->flexShrink * item->flexBaseSize;
                    }
                }
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = items[j];
                    if (!isFrozen[j]) {
                        float ratio = item->flexShrink * item->flexBaseSize / unFrozenScaledFlexFactors;
                        item->result.size[mainAxis] = item->flexBaseSize + remainingFreeSpace * ratio;
                    }
                }
            }
            //    Otherwise
            //         Do nothing.
            
            // d. Fix min/max violations. Clamp each non-frozen item’s target main size by its min and max main size properties. If the item’s target main size was made smaller by this, it’s a max violation. If the item’s target main size was made larger by this, it’s a min violation.
            float totalViolation = 0;
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = items[j];
                if (!isFrozen[j]) {
                    float targetMainSize = item->result.size[mainAxis];
                    float clampedSize = clamp(targetMainSize, flex_resolve(item->minSize[mainAxis], context, resolvedInnerSize.size[mainAxis]), flex_resolve(item->maxSize[mainAxis], context, resolvedInnerSize.size[mainAxis]));
                    violations[j] = clampedSize == targetMainSize ? 0 : clampedSize < targetMainSize ? 1 : -1;    // 1/-1 means max/min
                    totalViolation += clampedSize - targetMainSize;
                    item->result.size[mainAxis] = clampedSize;
                }
            }
            
            // e. Freeze over-flexed items. The total violation is the sum of the adjustments from the previous step ∑(clamped size - unclamped size). If the total violation is:
            //    Zero
            //         Freeze all items.
            if (totalViolation == 0) {
                unfrozenCount = 0;
            }
            //    Positive
            //         Freeze all the items with min violations.
            else if (totalViolation > 0) {
                for (j=lineStart;j<lineEnd;j++) {
                    if (!isFrozen[j]) {
                        if (violations[j] < 0) {
                            isFrozen[j] = true;
                            unfrozenCount--;
                        }
                    }
                }
            }
            //    Negative
            //         Freeze all the items with max violations.
            else {
                for (j=lineStart;j<lineEnd;j++) {
                    if (!isFrozen[j]) {
                        if (violations[j] > 0) {
                            isFrozen[j] = true;
                            unfrozenCount--;
                        }
                    }
                }
            }
            
            // f. Return to the start of this loop.
        }
        lineStart = lineEnd;
    }
    free(isFrozen);
    free(violations);
    
    ///////////////////////////////////////////////////////////////////////////
    //  Cross Size Determination
    
    // 7. Determine the hypothetical cross size of each item by performing layout with the used main size and the available space, treating auto as fit-content.
    for (i=0;i<flexItemsCount;i++) {
        FlexNode* item = items[i];
        FlexLength oldMainSize = item->size[mainAxis];
        item->size[mainAxis] = flexLength(item->result.size[mainAxis], FlexLengthTypeDefault);
        FlexSize childConstrainedSize;
        childConstrainedSize.size[mainAxis] = item->result.size[mainAxis] - flex_inset(item->resolvedMargin, mainAxis);
        childConstrainedSize.size[crossAxis] = availableSize.size[crossAxis] == FlexAuto ? FlexAuto : availableSize.size[crossAxis] - flex_inset(item->resolvedMargin, crossAxis);
        _layoutFlexNode(item, context, childConstrainedSize, flags, false);
        item->size[mainAxis] = oldMainSize;
    }
    
    // 8. Calculate the cross size of each flex line.
    //    If the flex container is single-line and has a definite cross size, the cross size of the flex line is the flex container’s inner cross size.
    float itemsCrossSize = 0;
    float resolvedInnerCrossSize = resolvedSize.size[crossAxis] != FlexAuto ? resolvedSize.size[crossAxis] - flex_inset(node->resolvedPadding, crossAxis) : FlexAuto;
    if (!node->wrap && resolvedSize.size[crossAxis] != FlexAuto) {
        itemsCrossSize = resolvedInnerCrossSize;
        lines[0].itemsSize = itemsCrossSize;
        
        // prepare for baseline alignment
        float maxAscender = 0;
        for (j=0;j<lines[0].itemsCount;j++) {
            FlexNode *item = items[j];
            if (mainAxis == FlexHorizontal && item->alignSelf == FlexBaseline && !hasAutoMargin(item, crossAxis)) {
                float ascender;
                flex_baseline(item, &ascender, NULL);
                
                if (ascender > maxAscender) {
                    maxAscender = ascender;
                }
            }
        }
        lines[0].ascender = maxAscender;
    }
    //Otherwise, for each flex line:
    else {
        lineStart = 0;
        for (i=0;i<linesCount;i++) {
            int lineEnd = lineStart + lines[i].itemsCount;
            
            float maxOuterHypotheticalCrossSize = 0;
            float maxAscender = 0;
            float maxDescender = 0;
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = items[j];
                
                //    1. Collect all the flex items whose inline-axis is parallel to the main-axis, whose align-self is baseline, and whose cross-axis margins are both non-auto. Find the largest of the distances between each item’s baseline and its hypothetical outer cross-start edge, and the largest of the distances between each item’s baseline and its hypothetical outer cross-end edge, and sum these two values.
                // only the horizontal text layout is supported
                if (mainAxis == FlexHorizontal && item->alignSelf == FlexBaseline && !hasAutoMargin(item, crossAxis)) {
                    float ascender, descender;
                    flex_baseline(item, &ascender, &descender);
                    
                    if (ascender > maxAscender) maxAscender = ascender;
                    if (descender > maxDescender) maxDescender = descender;
                }
                //    2. Among all the items not collected by the previous step, find the largest outer hypothetical cross size.
                else {
                    float itemOuterHypotheticalCrossSize = item->result.size[crossAxis] + flex_inset(item->resolvedMargin, crossAxis);
                    if (itemOuterHypotheticalCrossSize > maxOuterHypotheticalCrossSize) {
                        maxOuterHypotheticalCrossSize = itemOuterHypotheticalCrossSize;
                    }
                }
            }
            
            lines[i].ascender = maxAscender;
            
            //    3. The used cross-size of the flex line is the largest of the numbers found in the previous two steps and zero.
            float usedCrossSize = fmax(0.f, fmax(maxOuterHypotheticalCrossSize, maxAscender + maxDescender));
            
            //       If the flex container is single-line, then clamp the line’s cross-size to be within the container’s computed min and max cross-size properties. Note that if CSS 2.1’s definition of min/max-width/height applied more generally, this behavior would fall out automatically.
            if (!node->wrap) {
                usedCrossSize = clamp(usedCrossSize, resolvedMinCrossSize, resolvedMaxCrossSize);
            }
            if (i > 0) itemsCrossSize += lineSpacing;
            itemsCrossSize += usedCrossSize;
            lines[i].itemsSize = usedCrossSize;
            
            lineStart = lineEnd;
        }
    }
    
    node->ascender = lines[0].ascender ? lines[0].ascender + node->resolvedPadding[flex_start[crossAxis]] : FlexUndefined;
    
    if (flags == FlexLayoutFlagLayout) {
    // 9. Handle 'align-content: stretch'. If the flex container has a definite cross size, align-content is stretch, and the sum of the flex lines' cross sizes is less than the flex container’s inner cross size, increase the cross size of each flex line by equal amounts such that the sum of their cross sizes exactly equals the flex container’s inner cross size.
    if (resolvedSize.size[crossAxis] != FlexAuto && node->alignContent == FlexStretch && itemsCrossSize < resolvedInnerCrossSize) {
        float increment = (resolvedInnerCrossSize - itemsCrossSize) / linesCount;
        for (i=0;i<linesCount;i++) {
            lines[i].itemsSize += increment;
        }
    }
    
    // 10. Collapse visibility:collapse items. If any flex items have visibility: collapse, note the cross size of the line they’re in as the item’s strut size, and restart layout from the beginning.
    //     In this second layout round, when collecting items into lines, treat the collapsed items as having zero main size. For the rest of the algorithm following that step, ignore the collapsed items entirely (as if they were display:none) except that after calculating the cross size of the lines, if any line’s cross size is less than the largest strut size among all the collapsed items in the line, set its cross size to that strut size.
    //     Skip this step in the second layout round.
    // TODO supports visibility property ?
    
    // 11. Determine the used cross size of each flex item. If a flex item has align-self: stretch, its computed cross size property is auto, and neither of its cross-axis margins are auto, the used outer cross size is the used cross size of its flex line, clamped according to the item’s min and max cross size properties. Otherwise, the used cross size is the item’s hypothetical cross size.
    //     If the flex item has align-self: stretch, redo layout for its contents, treating this used size as its definite cross size so that percentage-sized children can be resolved.
    //     > Note that this step does not affect the main size of the flex item, even if it has an intrinsic aspect ratio.
    lineStart = 0;
    for (i=0;i<linesCount;i++) {
        int lineEnd = lineStart + lines[i].itemsCount;
        
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            
            FlexLength oldCrossSize = item->size[crossAxis];
            if (item->alignSelf == FlexStretch && item->size[crossAxis].value == FlexAuto && !hasAutoMargin(item, crossAxis)) {
                item->size[crossAxis].type = FlexLengthTypeDefault;
                item->size[crossAxis].value = item->result.size[crossAxis] = lines[i].itemsSize - flex_inset(item->resolvedMargin, crossAxis);
            }
            
            item->result.size[crossAxis] = clamp(item->result.size[crossAxis], flex_resolve(item->minSize[crossAxis], context, resolvedInnerSize.size[crossAxis]), flex_resolve(item->maxSize[crossAxis], context, resolvedInnerSize.size[crossAxis]));
            
            if (item->alignSelf == FlexStretch) {
                FlexLength oldMainSize = item->size[mainAxis];
                item->size[crossAxis] = flexLength(item->result.size[crossAxis], FlexLengthTypeDefault);
                item->size[mainAxis] = flexLength(item->result.size[mainAxis], FlexLengthTypeDefault);
                _layoutFlexNode(item, context, availableSize, flags, false);
                item->size[mainAxis] = oldMainSize;
            }
            item->size[crossAxis] = oldCrossSize;
        }
        
        lineStart = lineEnd;
    }
    
    ///////////////////////////////////////////////////////////////////////////
    //  Main-Axis Alignment
    
    // 12. Distribute any remaining free space. For each flex line:
    lineStart = 0;
    for (i=0;i<linesCount;i++) {
        int lineEnd = lineStart + lines[i].itemsCount;
        
        float lineMainSize = 0;
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            lineMainSize += item->result.size[mainAxis] + flex_inset(item->resolvedMargin, mainAxis);
        }
        lineMainSize += (lines[i].itemsCount - 1) * spacing;
        
        float remainMainSize = innerMainSize - lineMainSize;
        //       1. If the remaining free space is positive and at least one main-axis margin on this line is auto, distribute the free space equally among these margins.
        if (remainMainSize > 0) {
            int count = 0;
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = items[j];
                if (item->resolvedMargin[flex_start[node->direction]] == FlexAuto) count++;
                if (item->resolvedMargin[flex_end[node->direction]] == FlexAuto) count++;
            }
            if (count > 0) {
                float autoMargin = remainMainSize / count;
                remainMainSize = 0;
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = items[j];
                    if (item->resolvedMargin[flex_start[node->direction]] == FlexAuto) item->result.margin[flex_start[node->direction]] = autoMargin;
                    if (item->resolvedMargin[flex_end[node->direction]] == FlexAuto) item->result.margin[flex_end[node->direction]] = autoMargin;
                }
            }
        }
        //          Otherwise, set all auto margins to zero.
        else {
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = items[j];
                if (item->resolvedMargin[flex_start[node->direction]] == FlexAuto) item->result.margin[flex_start[node->direction]] = 0;
                if (item->resolvedMargin[flex_end[node->direction]] == FlexAuto) item->result.margin[flex_end[node->direction]] = 0;
            }
        }
        
        //       2. Align the items along the main-axis per justify-content.
        float offsetStart = node->resolvedPadding[flex_start[node->direction]];
        float offsetStep = 0;
        switch (node->justifyContent) {
            case FlexStart:
                break;
            case FlexCenter:
                offsetStart += remainMainSize / 2;
                break;
            case FlexEnd:
                offsetStart += remainMainSize;
                break;
            case FlexSpaceBetween:
                offsetStep = remainMainSize / (lines[i].itemsCount - 1);
                break;
            case FlexSpaceAround:
                offsetStep = remainMainSize / lines[i].itemsCount;
                offsetStart += offsetStep / 2;
                break;
            default:
                assert(false);
        }
        
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            offsetStart += item->result.margin[flex_start[node->direction]];
            item->result.position[flex_start[mainAxis]] = isReverse ? node->result.size[mainAxis] - offsetStart - item->result.size[mainAxis] : offsetStart;
            offsetStart += item->result.size[mainAxis] + item->result.margin[flex_end[node->direction]] + offsetStep + spacing;
        }
        
        lineStart = lineEnd;
    }
    
    ///////////////////////////////////////////////////////////////////////////
    //  Cross-Axis Alignment
    
    // 13. Resolve cross-axis auto margins. If a flex item has auto cross-axis margins:
    //       * If its outer cross size (treating those auto margins as zero) is less than the cross size of its flex line, distribute the difference in those sizes equally to the auto margins.
    lineStart = 0;
    for (i=0;i<linesCount;i++) {
        int lineEnd = lineStart + lines[i].itemsCount;
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            
            float remindCrossSize = lines[i].itemsSize - (item->result.size[crossAxis] + flex_inset(item->resolvedMargin, crossAxis));
            if (remindCrossSize > 0) {
                if (item->resolvedMargin[flex_start[crossAxis]] == FlexAuto && item->resolvedMargin[flex_end[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_start[crossAxis]] = item->result.margin[flex_end[crossAxis]] = remindCrossSize / 2;
                } else if (item->resolvedMargin[flex_start[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_start[crossAxis]] = remindCrossSize;
                } else if (item->resolvedMargin[flex_end[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_end[crossAxis]] = remindCrossSize;
                }
            }
            //       * Otherwise, if the block-start or inline-start margin (whichever is in the cross axis) is auto, set it to zero. Set the opposite margin so that the outer cross size of the item equals the cross size of its flex line.
            else {
                if (item->resolvedMargin[flex_start[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_start[crossAxis]] = 0;
                }
//                item->result.margin[flex_end[crossAxis]] = elementsSizeInLine[i] - (item->result.size[crossAxis] + item->result.margin[flex_start[crossAxis]]);
            }
            
            // 14. Align all flex items along the cross-axis per align-self, if neither of the item’s cross-axis margins are auto.
            remindCrossSize = lines[i].itemsSize - (item->result.size[crossAxis] + flex_inset(item->result.margin, crossAxis));
            float itemResultCrossPosition = item->result.margin[flex_start[crossAxis]];
            switch (item->alignSelf) {
                case FlexStart:
                    break;
                case FlexCenter:
                    itemResultCrossPosition += remindCrossSize / 2;
                    break;
                case FlexEnd:
                    itemResultCrossPosition += remindCrossSize;
                    break;
                case FlexStretch:
                    break;
                case FlexBaseline:
                    if (mainAxis == FlexHorizontal && !hasAutoMargin(item, crossAxis)) {
                        itemResultCrossPosition = lines[i].ascender - item->ascender;
                    }
                    break;
                default:
                    assert(false);
                    break;
            }
            item->result.position[flex_start[crossAxis]] = itemResultCrossPosition;
        }
        
        lineStart = lineEnd;
    }
    }
    
    // 15. Determine the flex container’s used cross size:
    //       * If the cross size property is a definite size, use that, clamped by the min and max cross size properties of the flex container.
    if (resolvedSize.size[crossAxis] != FlexAuto) {
        node->result.size[crossAxis] = resolvedSize.size[crossAxis];
    }
    //       * Otherwise, use the sum of the flex lines' cross sizes, clamped by the min and max cross size properties of the flex container.
    else {
        node->result.size[crossAxis] = clamp(itemsCrossSize + resolvedPaddingSize.size[crossAxis], resolvedMinCrossSize, resolvedMaxCrossSize);
    }
    
    if (flags != FlexLayoutFlagLayout) {
        free(lines);
        free(items);
        return;
    }
    
    float innerCrossSize = node->result.size[crossAxis] - resolvedPaddingSize.size[crossAxis];
    
    // 16. Align all flex lines per align-content.
    lineStart = 0;
    float offsetStart = node->resolvedPadding[flex_start[crossAxis]];
    float offsetStep = 0;
    float remindCrossSize = innerCrossSize - itemsCrossSize;
    switch (node->alignContent) {
        case FlexStretch:
        case FlexStart:
            break;
        case FlexCenter:
            offsetStart += remindCrossSize / 2;
            break;
        case FlexEnd:
            offsetStart += remindCrossSize;
            break;
        case FlexSpaceBetween:
            offsetStep = remindCrossSize / (linesCount - 1);
            break;
        case FlexSpaceAround:
            offsetStep = remindCrossSize / linesCount;
            offsetStart += offsetStep / 2;
            break;
        default:
            assert(false);
    }
    float lineCrossPositionStart = offsetStart;
    for (i=0;i<linesCount;i++) {
        int lineEnd = lineStart + lines[i].itemsCount;
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = items[j];
            item->result.position[flex_start[crossAxis]] += lineCrossPositionStart;
        }
        lineCrossPositionStart += offsetStep + lines[i].itemsSize + lineSpacing;
        lineStart = lineEnd;
    }
    
    // layout fixed items
    for (i=0;i<fixedItemsCount;i++) {
        FlexNode* item = items[node->childrenCount - 1 - i];
        
        FlexSize childConstrainedSize;
        childConstrainedSize.size[FLEX_WIDTH] = node->result.size[FLEX_WIDTH];
        childConstrainedSize.size[FLEX_HEIGHT] = node->result.size[FLEX_HEIGHT];
        
        FlexLength oldWidth = item->size[FLEX_WIDTH];
        FlexLength oldHeight = item->size[FLEX_HEIGHT];
        if (item->size[FLEX_WIDTH].value == FlexAuto && !hasAutoMargin(item, FLEX_WIDTH)) {
            item->size[FLEX_WIDTH] = flexLength(node->result.size[FLEX_WIDTH] - flex_inset(item->resolvedMargin, FLEX_WIDTH), FlexLengthTypeDefault);
        }
        if (item->size[FLEX_HEIGHT].value == FlexAuto && !hasAutoMargin(item, FLEX_HEIGHT)) {
            item->size[FLEX_HEIGHT] = flexLength(node->result.size[FLEX_HEIGHT] - flex_inset(item->resolvedMargin, FLEX_HEIGHT), FlexLengthTypeDefault);
        }
        _layoutFlexNode(item, context, childConstrainedSize, flags, false);
        item->size[FLEX_WIDTH] = oldWidth;
        item->size[FLEX_HEIGHT] = oldHeight;
        
        float remindWidth = node->result.size[FLEX_WIDTH] - item->result.size[FLEX_WIDTH] - flex_inset(item->resolvedMargin, FLEX_WIDTH);
        float remindHeight = node->result.size[FLEX_HEIGHT] - item->result.size[FLEX_HEIGHT] - flex_inset(item->resolvedMargin, FLEX_HEIGHT);
        if (remindWidth > 0) {
            if (item->resolvedMargin[flex_start[FLEX_WIDTH]] == FlexAuto && item->resolvedMargin[flex_end[FLEX_WIDTH]] == FlexAuto) {
                item->result.margin[flex_start[FLEX_WIDTH]] = item->result.margin[flex_end[FLEX_WIDTH]] = remindWidth / 2;
            } else if (item->resolvedMargin[flex_start[FLEX_WIDTH]] == FlexAuto) {
                item->result.margin[flex_start[FLEX_WIDTH]] = remindWidth;
            } else if (item->resolvedMargin[flex_end[FLEX_WIDTH]] == FlexAuto) {
                item->result.margin[flex_end[FLEX_WIDTH]] = remindWidth;
            }
        } else {
            if (item->resolvedMargin[flex_start[FLEX_WIDTH]] == FlexAuto) item->result.margin[flex_start[FLEX_WIDTH]] = 0;
            if (item->resolvedMargin[flex_end[FLEX_WIDTH]] == FlexAuto) item->result.margin[flex_end[FLEX_WIDTH]] = 0;
        }
        
        assert(item->result.margin[0] != FlexAuto);
        
        if (remindHeight > 0) {
            if (item->resolvedMargin[flex_start[FLEX_HEIGHT]] == FlexAuto && item->resolvedMargin[flex_end[FLEX_HEIGHT]] == FlexAuto) {
                item->result.margin[flex_start[FLEX_HEIGHT]] = item->result.margin[flex_end[FLEX_HEIGHT]] = remindHeight / 2;
            } else if (item->resolvedMargin[flex_start[FLEX_HEIGHT]] == FlexAuto) {
                item->result.margin[flex_start[FLEX_HEIGHT]] = remindHeight;
            } else if (item->resolvedMargin[flex_end[FLEX_HEIGHT]] == FlexAuto) {
                item->result.margin[flex_end[FLEX_HEIGHT]] = remindHeight;
            }
        } else {
            if (item->resolvedMargin[flex_start[FLEX_HEIGHT]] == FlexAuto) item->result.margin[flex_start[FLEX_HEIGHT]] = 0;
            if (item->resolvedMargin[flex_end[FLEX_HEIGHT]] == FlexAuto) item->result.margin[flex_end[FLEX_HEIGHT]] = 0;
        }
        
        item->result.position[flex_start[FLEX_WIDTH]] = item->result.margin[flex_start[FLEX_WIDTH]];
        item->result.position[flex_start[FLEX_HEIGHT]] = item->result.margin[flex_start[FLEX_HEIGHT]];
    }
    
    // pixel snapping
    for (i=0;i<node->childrenCount;i++) {
        FlexNode *item = items[i];
        float right = item->result.position[FLEX_LEFT] + item->result.size[FLEX_WIDTH];
        float bottom = item->result.position[FLEX_TOP] + item->result.size[FLEX_HEIGHT];
        item->result.position[FLEX_LEFT] = FLEX_PIXEL_ROUND(item->result.position[FLEX_LEFT], context->scale);
        item->result.position[FLEX_TOP] = FLEX_PIXEL_ROUND(item->result.position[FLEX_TOP], context->scale);
        item->result.size[FLEX_WIDTH] = FLEX_PIXEL_ROUND(right, context->scale) - item->result.position[FLEX_LEFT];
        item->result.size[FLEX_HEIGHT] = FLEX_PIXEL_ROUND(bottom, context->scale) - item->result.position[FLEX_TOP];
    }
    
    free(items);
    free(lines);
}

void setupProperties(FlexNode* node) {
//    assert(node->size[FLEX_WIDTH].value >= 0);
//    assert(node->size[FLEX_HEIGHT].value >= 0);
//    assert(node->minSize[FLEX_WIDTH].value >= 0);
//    assert(node->minSize[FLEX_HEIGHT].value >= 0);
//    assert(node->maxSize[FLEX_WIDTH].value >= 0);
//    assert(node->maxSize[FLEX_HEIGHT].value >= 0);
//    assert(node->flexBasis.value >= 0);
    assert(node->alignSelf == FlexInherit || node->alignSelf == FlexStretch || node->alignSelf == FlexStart || node->alignSelf == FlexCenter || node->alignSelf == FlexEnd || node->alignSelf == FlexBaseline);
    assert(node->alignItems == FlexStretch || node->alignItems == FlexStart || node->alignItems == FlexCenter || node->alignItems == FlexEnd || node->alignItems == FlexBaseline);
    assert(node->justifyContent == FlexStart || node->justifyContent == FlexCenter || node->justifyContent == FlexEnd || node->justifyContent == FlexSpaceBetween || node->justifyContent == FlexSpaceAround);
    assert(node->alignContent == FlexStretch || node->alignContent == FlexStart || node->alignContent == FlexCenter || node->alignContent == FlexEnd || node->alignContent == FlexSpaceBetween || node->alignContent == FlexSpaceAround);
    
#if DEBUG
    node->result.position[FLEX_LEFT] = NAN;
    node->result.position[FLEX_TOP] = NAN;
    node->result.size[FLEX_WIDTH] = NAN;
    node->result.size[FLEX_HEIGHT] = NAN;
#endif
    
    for (int i=0;i<node->childrenCount;i++) {
        FlexNode *item = node->childAt(node->context, i);
        
        if (item->flexBasis.value == FlexUndefined) {
            item->flexBasis = item->size[flex_dim[node->direction]];
        }
        
        if (item->alignSelf == FlexInherit) {
            item->alignSelf = node->alignItems;
        }
        
        setupProperties(item);
    }
}

void layoutFlexNode(FlexNode* node, float constrainedWidth, float constrainedHeight, float scale) {
    FlexLayoutContext context;
    context.viewportWidth = constrainedWidth != FlexAuto ? constrainedWidth : 0;
    context.viewportHeight = constrainedHeight != FlexAuto ? constrainedHeight : 0;
    context.scale = scale;
    
    setupProperties(node);
    flex_resolveMarginAndPadding(node, &context, constrainedWidth, FlexVertical);
    node->result.margin[FLEX_LEFT] = node->resolvedMargin[FLEX_LEFT] == FlexAuto ? 0 : FLEX_PIXEL_ROUND(node->resolvedMargin[FLEX_LEFT], scale);
    node->result.margin[FLEX_TOP] = node->resolvedMargin[FLEX_TOP] == FlexAuto ? 0 : FLEX_PIXEL_ROUND(node->resolvedMargin[FLEX_TOP], scale);
    node->result.margin[FLEX_RIGHT] = node->resolvedMargin[FLEX_RIGHT] == FlexAuto ? 0 : FLEX_PIXEL_ROUND(node->resolvedMargin[FLEX_RIGHT], scale);
    node->result.margin[FLEX_BOTTOM] = node->resolvedMargin[FLEX_BOTTOM] == FlexAuto ? 0 : FLEX_PIXEL_ROUND(node->resolvedMargin[FLEX_BOTTOM], scale);
    FlexSize constrainedSize;
    constrainedSize.size[FLEX_WIDTH] = constrainedWidth == FlexAuto ? FlexAuto : (constrainedWidth - flex_inset(node->resolvedMargin, FLEX_WIDTH));
    constrainedSize.size[FLEX_HEIGHT] = constrainedHeight == FlexAuto ? FlexAuto : (constrainedHeight - flex_inset(node->resolvedMargin, FLEX_HEIGHT));
    _layoutFlexNode(node, &context, constrainedSize, FlexLayoutFlagLayout, true);
    node->result.position[FLEX_LEFT] = node->result.margin[FLEX_LEFT];
    node->result.position[FLEX_TOP] = node->result.margin[FLEX_TOP];
    node->result.size[FLEX_WIDTH] = FLEX_PIXEL_ROUND(node->result.size[FLEX_WIDTH], scale);
    node->result.size[FLEX_HEIGHT] = FLEX_PIXEL_ROUND(node->result.size[FLEX_HEIGHT], scale);
}

FlexNode* newFlexNode() {
    FlexNode* flexNode = (FlexNode *)malloc(sizeof(FlexNode));
    return flexNode;
}

void initFlexNode(FlexNode* node) {
    node->fixed = false;
    node->wrap = false;
    node->direction = FlexHorizontal;
    node->alignItems = FlexStretch;
    node->alignSelf = FlexInherit;
    node->alignContent = FlexStretch;
    node->justifyContent = FlexStart;
    node->flexBasis = FlexLengthUndefined;
    node->flexGrow  = 0;
    node->flexShrink = 1;
    node->size[FLEX_WIDTH] = FlexLengthAuto;
    node->size[FLEX_HEIGHT] = FlexLengthAuto;
    node->minSize[FLEX_WIDTH] = FlexLengthZero;
    node->minSize[FLEX_HEIGHT] = FlexLengthZero;
    node->maxSize[FLEX_WIDTH] = FlexLengthUndefined;
    node->maxSize[FLEX_HEIGHT] = FlexLengthUndefined;
    node->margin[FLEX_LEFT] = FlexLengthZero;
    node->margin[FLEX_TOP] = FlexLengthZero;
    node->margin[FLEX_RIGHT] = FlexLengthZero;
    node->margin[FLEX_BOTTOM] = FlexLengthZero;
    node->margin[FLEX_START] = FlexLengthUndefined;
    node->margin[FLEX_END] = FlexLengthUndefined;
    node->padding[FLEX_LEFT] = FlexLengthZero;
    node->padding[FLEX_TOP] = FlexLengthZero;
    node->padding[FLEX_RIGHT] = FlexLengthZero;
    node->padding[FLEX_BOTTOM] = FlexLengthZero;
    node->padding[FLEX_START] = FlexLengthUndefined;
    node->padding[FLEX_END] = FlexLengthUndefined;
    node->border[FLEX_LEFT] = FlexLengthZero;
    node->border[FLEX_TOP] = FlexLengthZero;
    node->border[FLEX_RIGHT] = FlexLengthZero;
    node->border[FLEX_BOTTOM] = FlexLengthZero;
    node->border[FLEX_START] = FlexLengthUndefined;
    node->border[FLEX_END] = FlexLengthUndefined;
    node->spacing = FlexLengthZero;
    node->lineSpacing = FlexLengthZero;
    
    node->measure = NULL;
    node->childAt = NULL;
    node->baseline = NULL;
    
    node->measuredSizeCache = kh_init(FlexSize);
}

void freeFlexNode(FlexNode* node) {
    kh_destroy(FlexSize, node->measuredSizeCache);
    free(node);
}
