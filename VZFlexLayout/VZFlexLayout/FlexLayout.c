//
//  FlexLayout.m
//  oc_test
//
//  Created by Sleen on 16/1/25.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#include "FlexLayout.h"

#include <stdlib.h>
#include <assert.h>
#include <float.h>
#include <math.h>

float clamp(float value, float minValue, float maxValue) {
    if (maxValue == FlexInfinite) {
        return fmax(value, minValue);
    } else {
        return fmax(fmin(value, maxValue), minValue);
    }
}

float clampMax(float value, float maxValue) {
    if (maxValue == FlexInfinite) {
        return value;
    } else {
        return fmin(value, maxValue);
    }
}

static FlexPositionIndex flex_start[2] = { FLEX_LEFT, FLEX_TOP };
static FlexPositionIndex flex_end[2] = { FLEX_RIGHT, FLEX_BOTTOM };

float getMargin(FlexNode* node, FlexDirection direction) {
    return (node->margin[flex_start[direction]] != FlexAuto ? node->margin[flex_start[direction]] : 0) + (node->margin[flex_end[direction]] != FlexAuto ? node->margin[flex_end[direction]] : 0);
}

float getPadding(FlexNode* node, FlexDirection direction) {
    return node->padding[flex_start[direction]] + node->padding[flex_end[direction]]
        + node->border[flex_start[direction]] + node->border[flex_end[direction]];
}

float hasAutoMargin(FlexNode* node, FlexDirection direction) {
    return node->margin[flex_start[direction]] == FlexAuto || node->margin[flex_end[direction]] == FlexAuto;
}

void _layoutFlexNode(FlexNode* node, FlexSize constraintedSize, bool fill) {
    constraintedSize.size[FLEX_WIDTH] = constraintedSize.size[FLEX_WIDTH] == FlexInfinite ? FlexInfinite : fmax(0, constraintedSize.size[FLEX_WIDTH]);
    constraintedSize.size[FLEX_HEIGHT] = constraintedSize.size[FLEX_HEIGHT] == FlexInfinite ? FlexInfinite : fmax(0, constraintedSize.size[FLEX_HEIGHT]);
    
    if (fill && node->size[FLEX_WIDTH] == FlexAuto && constraintedSize.size[FLEX_WIDTH] != FlexInfinite) {
        node->size[FLEX_WIDTH] = constraintedSize.size[FLEX_WIDTH];
    }
    if (fill && node->size[FLEX_HEIGHT] == FlexAuto && constraintedSize.size[FLEX_HEIGHT] != FlexInfinite) {
        node->size[FLEX_HEIGHT] = constraintedSize.size[FLEX_HEIGHT];
    }
    
    if (node->size[FLEX_WIDTH] != FlexAuto) {
        node->result.size[FLEX_WIDTH] = clamp(node->size[FLEX_WIDTH], node->minSize[FLEX_WIDTH], node->maxSize[FLEX_WIDTH]);
    }
    if (node->size[FLEX_HEIGHT] != FlexAuto) {
        node->result.size[FLEX_HEIGHT] = clamp(node->size[FLEX_HEIGHT], node->minSize[FLEX_HEIGHT], node->maxSize[FLEX_HEIGHT]);
    }
    
    // measure non-container element
    if (node->childrenCount == 0 && node->measure) {
        if (node->size[FLEX_WIDTH] == FlexAuto || node->size[FLEX_HEIGHT] == FlexAuto) {
            FlexSize childConstraintedSize;
            childConstraintedSize.size[FLEX_WIDTH] = node->size[FLEX_WIDTH] == FlexAuto ? (constraintedSize.size[FLEX_WIDTH] != FlexInfinite ? constraintedSize.size[FLEX_WIDTH] - getPadding(node, FLEX_WIDTH) : FLT_MAX) : node->result.size[FLEX_WIDTH];
            childConstraintedSize.size[FLEX_HEIGHT] = node->size[FLEX_HEIGHT] == FlexAuto ? (constraintedSize.size[FLEX_HEIGHT] != FlexInfinite ? constraintedSize.size[FLEX_HEIGHT] - getPadding(node, FLEX_HEIGHT) : FLT_MAX) : node->result.size[FLEX_HEIGHT];
            FlexSize size = node->measure(node->context, childConstraintedSize);
            if (node->size[FLEX_WIDTH] == FlexAuto) {
                node->result.size[FLEX_WIDTH] = clamp(size.size[FLEX_WIDTH] + getPadding(node, FLEX_WIDTH), node->minSize[FLEX_WIDTH], node->maxSize[FLEX_WIDTH]);
            }
            if (node->size[FLEX_HEIGHT] == FlexAuto) {
                node->result.size[FLEX_HEIGHT] = clamp(size.size[FLEX_HEIGHT] + getPadding(node, FLEX_HEIGHT), node->minSize[FLEX_HEIGHT], node->maxSize[FLEX_HEIGHT]);
            }
        }
        return;
    }
    else if (node->childrenCount == 0) {
        if (node->size[FLEX_WIDTH] == FlexAuto) {
            node->result.size[FLEX_WIDTH] = clamp(getPadding(node, FLEX_WIDTH), node->minSize[FLEX_WIDTH], node->maxSize[FLEX_WIDTH]);
        }
        if (node->size[FLEX_HEIGHT] == FlexAuto) {
            node->result.size[FLEX_HEIGHT] = clamp(getPadding(node, FLEX_HEIGHT), node->minSize[FLEX_HEIGHT], node->maxSize[FLEX_HEIGHT]);
        }
        return;
    }
    
    // reference: http://www.w3.org/TR/css3-flexbox/#layout-algorithm
    
    ///////////////////////////////////////////////////////////////////////////
    //  Initial Setup
    
    // 0. Generate anonymous flex items as described in the Flex Items section.
    /* here is no anonymous items */
    
    // 1. Re-order the flex items (and any absolutely positioned flex container children) according to their order. The flex items with the lowest (most negative) order values are first in the ordering. If multiple flex items share an order value, they’re ordered by document order. This effectively changes the order of their boxes in the box-tree, and how the rest of this algorithm deals with the generated flex items.
    /* the order property is not supported yet */
    
    ///////////////////////////////////////////////////////////////////////////
    //  Line Length Determination
    
    // 2. Determine the available main and cross space for the flex items. For each dimension, if that dimension of the flex container’s content box is a definite size, use that; otherwise, subtract the flex container’s margin, border, and padding from the space available to the flex container in that dimension and use that value. This might result in an infinite value.
    
    FlexDirection mainAxis = node->direction;
    FlexDirection crossAxis = mainAxis == FlexHorizontal ? FlexVertical : FlexHorizontal;
    
    FlexSize availableSize;
    availableSize.size[FLEX_WIDTH] = node->size[FLEX_WIDTH] != FlexAuto ? node->size[FLEX_WIDTH] - getPadding(node, FLEX_WIDTH)
        : constraintedSize.size[FLEX_WIDTH] == FlexInfinite ? FlexInfinite
        : (constraintedSize.size[FLEX_WIDTH] - getMargin(node, FLEX_WIDTH) - getPadding(node, FLEX_WIDTH));
    availableSize.size[FLEX_HEIGHT] = node->size[FLEX_HEIGHT] != FlexAuto ? node->size[FLEX_HEIGHT] - getPadding(node, FLEX_HEIGHT)
        : constraintedSize.size[FLEX_HEIGHT] == FlexInfinite ? FlexInfinite
        : (constraintedSize.size[FLEX_HEIGHT] - getMargin(node, FLEX_HEIGHT) - getPadding(node, FLEX_HEIGHT));
    
    int* elementsCountInLine = malloc(sizeof(int) * node->childrenCount);
    float* elementsSizeInLine = malloc(sizeof(float) * node->childrenCount);
    elementsCountInLine[0] = 0;
    elementsSizeInLine[0] = 0;
    int linesCount = 1;
    
    int i, j;
    
    // 3. Determine the flex base size and hypothetical main size of each item:
    for (i=0;i<node->childrenCount;i++) {
        FlexNode* item = node->childAt(node->context, i);
        if (item->fixed) continue;
        
        float itemBaseSize;
        float itemHypotheticalMainSize;
        
        // A. If the item has a definite used flex basis, that’s the flex base size.
        if (item->flexBasis != FlexAuto) {
            itemBaseSize = item->flexBasis;
        }
        
        // B. If the flex item has ...
        //      * an intrinsic aspect ratio,
        //      * a used flex basis of content, and
        //      * a definite cross size
        //    then the flex base size is calculated from its inner cross size and the flex item’s intrinsic aspect ratio.
        // TODO supports aspect ratio ?
        
        // C. If the used flex basis is content or depends on its available size, and the flex container is being sized under a min-content or max-content constraint (e.g. when performing automatic table layout [CSS21]), size the item under that constraint. The flex base size is the item’s resulting main size.
        // TODO supports min-content or max-content constraint ?
        
        // D. Otherwise, if the used flex basis is content or depends on its available size, the available main size is infinite, and the flex item’s inline axis is parallel to the main axis, lay the item out using the rules for a box in an orthogonal flow [CSS3-WRITING-MODES]. The flex base size is the item’s max-content main size.
        // > Note: This case occurs, for example, in an English document (horizontal writing mode) containing a column flex container containing a vertical Japanese (vertical writing mode) flex item.
        // FIXME
        
        // E. Otherwise, size the item into the available space using its used flex basis in place of its main size, treating a value of content as max-content. If a cross size is needed to determine the main size (e.g. when the flex item’s main size is in its block axis) and the flex item’s cross size is auto and not definite, in this calculation use fit-content as the flex item’s cross size. The flex base size is the item’s resulting main size.
        else {
            float oldMainSize = item->size[mainAxis];
            item->size[mainAxis] = item->flexBasis;
            _layoutFlexNode(item, availableSize, false);
            item->size[mainAxis] = oldMainSize;
            itemBaseSize = item->result.size[mainAxis];
        }
        
        item->flexBasis = itemBaseSize;
        
        // When determining the flex base size, the item’s min and max main size properties are ignored (no clamping occurs).
        // The hypothetical main size is the item’s flex base size clamped according to its min and max main size properties.
        itemHypotheticalMainSize = clamp(itemBaseSize, item->minSize[mainAxis], item->maxSize[mainAxis]);
        item->result.size[mainAxis] = itemHypotheticalMainSize;
        float outerItemHypotheticalMainSize = itemHypotheticalMainSize + getMargin(item, mainAxis);
        
        ///////////////////////////////////////////////////////////////////////////
        //  Main Size Determination
        
        // 5. Collect flex items into flex lines:
        //     * If the flex container is single-line, collect all the flex items into a single flex line.
        if (!node->wrap) {
            if (elementsCountInLine[linesCount - 1] > 0) elementsSizeInLine[linesCount - 1] += node->spacing;
            elementsSizeInLine[linesCount - 1] += outerItemHypotheticalMainSize;
            elementsCountInLine[linesCount - 1]++;
        }
        //     * Otherwise, starting from the first uncollected item, collect consecutive items one by one until the first time that the next collected item would not fit into the flex container’s inner main size (or until a forced break is encountered, see §10 Fragmenting Flex Layout). If the very first uncollected item wouldn’t fit, collect just it into the line.
        /* line break not supported yet */
        //       For this step, the size of a flex item is its outer hypothetical main size.
        //       Repeat until all flex items have been collected into flex lines.
        //       > Note that the "collect as many" line will collect zero-sized flex items onto the end of the previous line even if the last non-zero item exactly "filled up" the line.
        else {
            if (elementsCountInLine[linesCount - 1] > 0) outerItemHypotheticalMainSize += node->spacing;
            if (elementsSizeInLine[linesCount - 1] + outerItemHypotheticalMainSize > availableSize.size[mainAxis]) {
                if (elementsCountInLine[linesCount - 1] == 0) {
                    elementsCountInLine[linesCount - 1] = 1;
                    elementsSizeInLine[linesCount - 1] = outerItemHypotheticalMainSize;
                }
                else {
                    if (elementsCountInLine[linesCount - 1] > 0) outerItemHypotheticalMainSize -= node->spacing;
                    elementsCountInLine[linesCount] = 1;
                    elementsSizeInLine[linesCount] = outerItemHypotheticalMainSize;
                    linesCount++;
                }
            }
            else {
                elementsCountInLine[linesCount - 1]++;
                elementsSizeInLine[linesCount - 1] += outerItemHypotheticalMainSize;
            }
        }
    }
    
    assert(node->wrap || linesCount == 1);
    
    float itemsMainSize = 0;
    for (i=0;i<linesCount;i++) {
        if (elementsSizeInLine[i] > itemsMainSize) {
            // lineSize means the item's main size, and it will be used to store the lines' cross size below
            itemsMainSize = elementsSizeInLine[i];
        }
    }
    
    // 4. Determine the main size of the flex container using the rules of the formatting context in which it participates. For this computation, auto margins on flex items are treated as 0.
    node->result.size[mainAxis] = node->size[mainAxis] != FlexAuto ? node->size[mainAxis] : clampMax(itemsMainSize + getPadding(node, mainAxis), constraintedSize.size[mainAxis] != FlexInfinite ? constraintedSize.size[mainAxis] - getMargin(node, mainAxis) : FlexInfinite);
    float innerMainSize = node->result.size[mainAxis] - getPadding(node, mainAxis);
    
    // 6. Resolve the flexible lengths of all the flex items to find their used main size (see section 9.7.).
    bool* isFrozen = malloc(sizeof(bool) * node->childrenCount);
    char* violations = malloc(sizeof(char) * node->childrenCount);
    int lineStart = 0;
    for (i=0;i<linesCount;i++) {
        int count = elementsCountInLine[i];
        int unfrozenCount = count;
        int lineEnd = lineStart + count;
        
        // 6.1 Determine the used flex factor. Sum the outer hypothetical main sizes of all items on the line. If the sum is less than the flex container’s inner main size, use the flex grow factor for the rest of this algorithm; otherwise, use the flex shrink factor.
        float lineMainSize = 0;
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            lineMainSize += item->result.size[mainAxis] + getMargin(item, mainAxis);
        }
        float itemsSpacing = (count - 1) * node->spacing;
        lineMainSize += itemsSpacing;
        bool usingFlexGrowFactor = lineMainSize < availableSize.size[mainAxis];
        float initialFreeSpace = innerMainSize - itemsSpacing;
        
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            // 6.2 Size inflexible items. Freeze, setting its target main size to its hypothetical main size…
            //       * any item that has a flex factor of zero
            //       * if using the flex grow factor: any item that has a flex base size greater than its hypothetical main size
            //       * if using the flex shrink factor: any item that has a flex base size smaller than its hypothetical main size
            // 6.3 Calculate initial free space. Sum the outer sizes of all items on the line, and subtract this from the flex container’s inner main size. For frozen items, use their outer target main size; for other items, use their outer flex base size.
            if ((usingFlexGrowFactor ? item->flexGrow : item->flexShrink * item->flexBasis) == 0
                || (usingFlexGrowFactor && item->flexBasis > item->result.size[mainAxis])
                || (!usingFlexGrowFactor && item->flexBasis < item->result.size[mainAxis])) {
                isFrozen[j] = true;
                unfrozenCount--;
                initialFreeSpace -= item->result.size[mainAxis] + getMargin(item, mainAxis);
            } else {
                isFrozen[j] = false;
                initialFreeSpace -= item->flexBasis + getMargin(item, mainAxis);
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
                FlexNode *item = node->childAt(node->context, j);
                if (item->fixed) continue;
                if (isFrozen[j]) {
                    remainingFreeSpace -= item->result.size[mainAxis] + getMargin(item, mainAxis);
                }
                else {
                    remainingFreeSpace -= item->flexBasis + getMargin(item, mainAxis);
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
                    FlexNode *item = node->childAt(node->context, j);
                    if (!item->fixed && !isFrozen[j]) {
                        float ratio = item->flexGrow / unFrozenFlexFactors;
                        item->result.size[mainAxis] = item->flexBasis + remainingFreeSpace * ratio;
                    }
                }
            }
            //    If using the flex shrink factor
            //         For every unfrozen item on the line, multiply its flex shrink factor by its inner flex base size, and note this as its scaled flex shrink factor. Find the ratio of the item’s scaled flex shrink factor to the sum of the scaled flex shrink factors of all unfrozen items on the line. Set the item’s target main size to its flex base size minus a fraction of the absolute value of the remaining free space proportional to the ratio. Note this may result in a negative inner main size; it will be corrected in the next step.
            else if (!usingFlexGrowFactor && unFrozenFlexFactors > 0) {
                float unFrozenScaledFlexFactors = 0;
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = node->childAt(node->context, j);
                    if (!item->fixed && !isFrozen[j]) {
                        unFrozenScaledFlexFactors += item->flexShrink * item->flexBasis;
                    }
                }
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = node->childAt(node->context, j);
                    if (!item->fixed && !isFrozen[j]) {
                        float ratio = item->flexShrink * item->flexBasis / unFrozenScaledFlexFactors;
                        item->result.size[mainAxis] = item->flexBasis + remainingFreeSpace * ratio;
                    }
                }
            }
            //    Otherwise
            //         Do nothing.
            
            // d. Fix min/max violations. Clamp each non-frozen item’s target main size by its min and max main size properties. If the item’s target main size was made smaller by this, it’s a max violation. If the item’s target main size was made larger by this, it’s a min violation.
            float totalViolation = 0;
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = node->childAt(node->context, j);
                if (item->fixed) continue;
                if (!isFrozen[j]) {
                    float targetMainSize = item->result.size[mainAxis];
                    float clampedSize = clamp(targetMainSize, item->minSize[mainAxis], item->maxSize[mainAxis]);
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
                    FlexNode *item = node->childAt(node->context, j);
                    if (item->fixed) continue;
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
                    FlexNode *item = node->childAt(node->context, j);
                    if (item->fixed) continue;
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
    
    ///////////////////////////////////////////////////////////////////////////
    //  Cross Size Determination
    
    // 7. Determine the hypothetical cross size of each item by performing layout with the used main size and the available space, treating auto as fit-content.
    for (i=0;i<node->childrenCount;i++) {
        FlexNode* item = node->childAt(node->context, i);
        if (item->fixed) continue;
        float oldMainSize = item->size[mainAxis];
        item->size[mainAxis] = item->result.size[mainAxis];
        FlexSize childConstraintedSize;
        childConstraintedSize.size[mainAxis] = item->result.size[mainAxis];
        childConstraintedSize.size[crossAxis] = availableSize.size[crossAxis];
        _layoutFlexNode(item, childConstraintedSize, false);
        item->size[mainAxis] = oldMainSize;
    }
    
    // 8. Calculate the cross size of each flex line.
    //    If the flex container is single-line and has a definite cross size, the cross size of the flex line is the flex container’s inner cross size.
    float itemsCrossSize = 0;
    float definitedCrossSize = node->size[crossAxis] != FlexAuto ? node->size[crossAxis] : FlexUndefined;
    float definitedInnerCrossSize = definitedCrossSize == FlexUndefined ? FlexUndefined : (definitedCrossSize - getPadding(node, crossAxis));
    if (!node->wrap && definitedCrossSize != FlexUndefined) {
        itemsCrossSize = definitedInnerCrossSize;
        elementsSizeInLine[0] = itemsCrossSize;
    }
    //Otherwise, for each flex line:
    else {
        lineStart = 0;
        for (i=0;i<linesCount;i++) {
            int lineEnd = lineStart + elementsCountInLine[i];
            
            //    1. Collect all the flex items whose inline-axis is parallel to the main-axis, whose align-self is baseline, and whose cross-axis margins are both non-auto. Find the largest of the distances between each item’s baseline and its hypothetical outer cross-start edge, and the largest of the distances between each item’s baseline and its hypothetical outer cross-end edge, and sum these two values.
            /* baseline not supported yet */
            
            //    2. Among all the items not collected by the previous step, find the largest outer hypothetical cross size.
            float largestOuterHypotheticalCrossSize = 0;
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = node->childAt(node->context, j);
                if (item->fixed) continue;
                float itemOuterHypotheticalCrossSize = item->result.size[crossAxis] + getMargin(item, crossAxis);
                if (itemOuterHypotheticalCrossSize > largestOuterHypotheticalCrossSize) {
                    largestOuterHypotheticalCrossSize = itemOuterHypotheticalCrossSize;
                }
            }
            
            //    3. The used cross-size of the flex line is the largest of the numbers found in the previous two steps and zero.
            float usedCrossSize = fmax(0.f, largestOuterHypotheticalCrossSize);
            
            //       If the flex container is single-line, then clamp the line’s cross-size to be within the container’s computed min and max cross-size properties. Note that if CSS 2.1’s definition of min/max-width/height applied more generally, this behavior would fall out automatically.
            if (!node->wrap) {
                usedCrossSize = clamp(usedCrossSize, node->minSize[crossAxis], node->maxSize[crossAxis]);
            }
            if (i > 0) itemsCrossSize += node->lineSpacing;
            itemsCrossSize += usedCrossSize;
            elementsSizeInLine[i] = usedCrossSize;
            
            lineStart = lineEnd;
        }
    }
    
    // 9. Handle 'align-content: stretch'. If the flex container has a definite cross size, align-content is stretch, and the sum of the flex lines' cross sizes is less than the flex container’s inner cross size, increase the cross size of each flex line by equal amounts such that the sum of their cross sizes exactly equals the flex container’s inner cross size.
    if (definitedCrossSize != FlexUndefined && node->alignContent == FlexStretch && itemsCrossSize < definitedInnerCrossSize) {
        float increment = (definitedInnerCrossSize - itemsCrossSize) / linesCount;
        for (i=0;i<linesCount;i++) {
            elementsSizeInLine[i] += increment;
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
        int lineEnd = lineStart + elementsCountInLine[i];
        
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            
            float oldCrossSize = item->size[crossAxis];
            if (item->alignSelf == FlexStretch && item->size[crossAxis] == FlexAuto && !hasAutoMargin(item, crossAxis)) {
                item->size[crossAxis] = item->result.size[crossAxis] = elementsSizeInLine[i] - getMargin(item, crossAxis);
            }
            
            item->result.size[crossAxis] = clamp(item->result.size[crossAxis], item->minSize[crossAxis], item->maxSize[crossAxis]);
            
            if (item->alignSelf == FlexStretch) {
                float oldMainSize = item->size[mainAxis];
                item->size[crossAxis] = item->result.size[crossAxis];
                item->size[mainAxis] = item->result.size[mainAxis];
                _layoutFlexNode(item, availableSize, false);
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
        int lineEnd = lineStart + elementsCountInLine[i];
        
        float lineMainSize = 0;
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            lineMainSize += item->result.size[mainAxis] + getMargin(item, mainAxis);
        }
        lineMainSize += (elementsCountInLine[i] - 1) * node->spacing;
        
        float remainMainSize = innerMainSize - lineMainSize;
        //       1. If the remaining free space is positive and at least one main-axis margin on this line is auto, distribute the free space equally among these margins.
        if (remainMainSize > 0) {
            int count = 0;
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = node->childAt(node->context, j);
                if (item->fixed) continue;
                if (item->margin[flex_start[mainAxis]] == FlexAuto) count++;
                if (item->margin[flex_end[mainAxis]] == FlexAuto) count++;
            }
            if (count > 0) {
                float autoMargin = remainMainSize / count;
                remainMainSize = 0;
                for (j=lineStart;j<lineEnd;j++) {
                    FlexNode *item = node->childAt(node->context, j);
                    if (item->fixed) continue;
                    if (item->margin[flex_start[mainAxis]] == FlexAuto) item->result.margin[flex_start[mainAxis]] = autoMargin;
                    if (item->margin[flex_end[mainAxis]] == FlexAuto) item->result.margin[flex_end[mainAxis]] = autoMargin;
                }
            }
        }
        //          Otherwise, set all auto margins to zero.
        else {
            for (j=lineStart;j<lineEnd;j++) {
                FlexNode *item = node->childAt(node->context, j);
                if (item->fixed) continue;
                if (item->margin[flex_start[mainAxis]] == FlexAuto) item->result.margin[flex_start[mainAxis]] = 0;
                if (item->margin[flex_end[mainAxis]] == FlexAuto) item->result.margin[flex_end[mainAxis]] = 0;
            }
        }
        
        //       2. Align the items along the main-axis per justify-content.
        float offsetStart;
        float offsetStep;
        switch (node->justifyContent) {
            case FlexStart:
                offsetStart = 0;
                offsetStep = 0;
                break;
            case FlexCenter:
                offsetStart = remainMainSize / 2;
                offsetStep = 0;
                break;
            case FlexEnd:
                offsetStart = remainMainSize;
                offsetStep = 0;
                break;
            case FlexSpaceBetween:
                offsetStart = 0;
                offsetStep = remainMainSize / (elementsCountInLine[i] - 1);
                break;
            case FlexSpaceAround:
                offsetStep = remainMainSize / elementsCountInLine[i];
                offsetStart = offsetStep / 2;
                break;
            default:
                assert(false);
        }
        
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            offsetStart += item->result.margin[flex_start[mainAxis]];
            item->result.position[flex_start[mainAxis]] = offsetStart;
            offsetStart += item->result.size[mainAxis] + item->result.margin[flex_end[mainAxis]] + offsetStep + node->spacing;
        }
        
        lineStart = lineEnd;
    }
    
    ///////////////////////////////////////////////////////////////////////////
    //  Cross-Axis Alignment
    
    // 13. Resolve cross-axis auto margins. If a flex item has auto cross-axis margins:
    //       * If its outer cross size (treating those auto margins as zero) is less than the cross size of its flex line, distribute the difference in those sizes equally to the auto margins.
    lineStart = 0;
    for (i=0;i<linesCount;i++) {
        int lineEnd = lineStart + elementsCountInLine[i];
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            
            float remindCrossSize = elementsSizeInLine[i] - (item->result.size[crossAxis] + getMargin(item, crossAxis));
            if (remindCrossSize > 0) {
                if (item->margin[flex_start[crossAxis]] == FlexAuto && item->margin[flex_end[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_start[crossAxis]] = item->result.margin[flex_end[crossAxis]] = remindCrossSize / 2;
                } else if (item->margin[flex_start[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_start[crossAxis]] = remindCrossSize;
                } else if (item->margin[flex_end[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_end[crossAxis]] = remindCrossSize;
                }
            }
            //       * Otherwise, if the block-start or inline-start margin (whichever is in the cross axis) is auto, set it to zero. Set the opposite margin so that the outer cross size of the item equals the cross size of its flex line.
            else {
                if (item->margin[flex_start[crossAxis]] == FlexAuto) {
                    item->result.margin[flex_start[crossAxis]] = 0;
                }
                item->result.margin[flex_end[crossAxis]] = elementsSizeInLine[i] - (item->result.size[crossAxis] + item->result.margin[flex_start[crossAxis]]);
            }
            
            // 14. Align all flex items along the cross-axis per align-self, if neither of the item’s cross-axis margins are auto.
            remindCrossSize = elementsSizeInLine[i] - (item->result.size[crossAxis] + item->result.margin[flex_start[crossAxis]] + item->result.margin[flex_end[crossAxis]]);
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
//                case FlexAlign::Baseline:
//                    // FIXME not supported yet
//                    assert(false);
//                    break;
                default:
                    assert(false);
                    break;
            }
            item->result.position[flex_start[crossAxis]] = itemResultCrossPosition;
        }
        
        lineStart = lineEnd;
    }
    
    // 15. Determine the flex container’s used cross size:
    //       * If the cross size property is a definite size, use that, clamped by the min and max cross size properties of the flex container.
    if (node->size[crossAxis] != FlexAuto) {
        
    }
    //       * Otherwise, use the sum of the flex lines' cross sizes, clamped by the min and max cross size properties of the flex container.
    else {
        node->result.size[crossAxis] = clamp(itemsCrossSize + getPadding(node, crossAxis), node->minSize[crossAxis], node->maxSize[crossAxis]);
    }
    
    float innerCrossSize = node->result.size[crossAxis] - getPadding(node, crossAxis);
    
    // 16. Align all flex lines per align-content.
    lineStart = 0;
    float offsetStart;
    float offsetStep;
    float remindCrossSize = innerCrossSize - itemsCrossSize;
    switch (node->alignContent) {
        case FlexStretch:
        case FlexStart:
            offsetStart = 0;
            offsetStep = 0;
            break;
        case FlexCenter:
            offsetStart = remindCrossSize / 2;
            offsetStep = 0;
            break;
        case FlexEnd:
            offsetStart = remindCrossSize;
            offsetStep = 0;
            break;
        case FlexSpaceBetween:
            offsetStart = 0;
            offsetStep = remindCrossSize / (linesCount - 1);
            break;
        case FlexSpaceAround:
            offsetStep = remindCrossSize / linesCount;
            offsetStart = offsetStep / 2;
            break;
        default:
            assert(false);
    }
    float lineCrossPositionStart = offsetStart;
    for (i=0;i<linesCount;i++) {
        int lineEnd = lineStart + elementsCountInLine[i];
        for (j=lineStart;j<lineEnd;j++) {
            FlexNode *item = node->childAt(node->context, j);
            if (item->fixed) continue;
            item->result.position[flex_start[crossAxis]] += lineCrossPositionStart;
        }
        lineCrossPositionStart += offsetStep + elementsSizeInLine[i] + node->lineSpacing;
        lineStart = lineEnd;
    }
    
    free(elementsCountInLine);
    free(elementsSizeInLine);
    free(isFrozen);
    free(violations);
    
    // layout fixed items
    for (i=0;i<node->childrenCount;i++) {
        FlexNode* item = node->childAt(node->context, i);
        if (!item->fixed) continue;
        FlexSize childConstraintedSize;
        childConstraintedSize.size[FLEX_WIDTH] = node->result.size[FLEX_WIDTH];
        childConstraintedSize.size[FLEX_HEIGHT] = node->result.size[FLEX_HEIGHT];
        _layoutFlexNode(item, childConstraintedSize, false);
        
        float remindMainSize = innerMainSize - item->result.size[mainAxis];
        float remindCrossSize = innerCrossSize - item->result.size[crossAxis];
        if (remindMainSize > 0) {
            if (item->margin[flex_start[mainAxis]] == FlexAuto && item->margin[flex_end[mainAxis]] == FlexAuto) {
                item->result.margin[flex_start[mainAxis]] = item->result.margin[flex_end[mainAxis]] = remindMainSize / 2;
            } else if (item->margin[flex_start[mainAxis]] == FlexAuto) {
                item->result.margin[flex_start[mainAxis]] = remindMainSize;
            } else if (item->margin[flex_end[mainAxis]] == FlexAuto) {
                item->result.margin[flex_end[mainAxis]] = remindMainSize;
            }
        } else {
            if (item->margin[flex_start[mainAxis]] == FlexAuto) item->result.margin[flex_start[mainAxis]] = 0;
            if (item->margin[flex_end[mainAxis]] == FlexAuto) item->result.margin[flex_end[mainAxis]] = 0;
        }
        
        if (remindCrossSize > 0) {
            if (item->margin[flex_start[crossAxis]] == FlexAuto && item->margin[flex_end[crossAxis]] == FlexAuto) {
                item->result.margin[flex_start[crossAxis]] = item->result.margin[flex_end[crossAxis]] = remindCrossSize / 2;
            } else if (item->margin[flex_start[crossAxis]] == FlexAuto) {
                item->result.margin[flex_start[crossAxis]] = remindCrossSize;
            } else if (item->margin[flex_end[crossAxis]] == FlexAuto) {
                item->result.margin[flex_end[crossAxis]] = remindCrossSize;
            }
        } else {
            if (item->margin[flex_start[crossAxis]] == FlexAuto) item->result.margin[flex_start[crossAxis]] = 0;
            if (item->margin[flex_end[crossAxis]] == FlexAuto) item->result.margin[flex_end[crossAxis]] = 0;
        }
        
        item->result.position[flex_start[mainAxis]] = item->result.margin[flex_start[mainAxis]];
        item->result.position[flex_start[crossAxis]] = item->result.margin[flex_start[crossAxis]];
    }
}

void setupProperties(FlexNode* node) {
    assert(node->size[FLEX_WIDTH] >= 0 || node->size[FLEX_WIDTH] == FlexAuto);
    assert(node->size[FLEX_HEIGHT] >= 0 || node->size[FLEX_HEIGHT] == FlexAuto);
    assert(node->minSize[FLEX_WIDTH] >= 0);
    assert(node->minSize[FLEX_HEIGHT] >= 0);
    assert(node->maxSize[FLEX_WIDTH] >= 0 || node->maxSize[FLEX_WIDTH] == FlexInfinite);
    assert(node->maxSize[FLEX_HEIGHT] >= 0 || node->maxSize[FLEX_HEIGHT] == FlexInfinite);
    assert(node->flexBasis >= 0 || node->flexBasis == FlexAuto || node->flexBasis == FlexContent);
    assert(node->alignSelf == FlexInherit || node->alignSelf == FlexStretch || node->alignSelf == FlexStart || node->alignSelf == FlexCenter || node->alignSelf == FlexEnd);
    assert(node->alignItems == FlexStretch || node->alignItems == FlexStart || node->alignItems == FlexCenter || node->alignItems == FlexEnd);
    assert(node->justifyContent == FlexStart || node->justifyContent == FlexCenter || node->justifyContent == FlexEnd || node->justifyContent == FlexSpaceBetween || node->justifyContent == FlexSpaceAround);
    assert(node->alignContent == FlexStretch || node->alignContent == FlexStart || node->alignContent == FlexCenter || node->alignContent == FlexEnd || node->alignContent == FlexSpaceBetween || node->alignContent == FlexSpaceAround);
    
    node->result.margin[FLEX_LEFT] = node->margin[FLEX_LEFT] == FlexAuto ? 0 : node->margin[FLEX_LEFT];
    node->result.margin[FLEX_TOP] = node->margin[FLEX_TOP] == FlexAuto ? 0 : node->margin[FLEX_TOP];
    node->result.margin[FLEX_RIGHT] = node->margin[FLEX_RIGHT] == FlexAuto ? 0 : node->margin[FLEX_RIGHT];
    node->result.margin[FLEX_BOTTOM] = node->margin[FLEX_BOTTOM] == FlexAuto ? 0 : node->margin[FLEX_BOTTOM];
    node->result.position[FLEX_LEFT] = NAN;
    node->result.position[FLEX_TOP] = NAN;
    node->result.size[FLEX_WIDTH] = NAN;
    node->result.size[FLEX_HEIGHT] = NAN;
    
    for (int i=0;i<node->childrenCount;i++) {
        FlexNode *item = node->childAt(node->context, i);
        
        if (item->flexBasis == FlexContent) {
            item->flexBasis = FlexAuto;
        } else if (item->flexBasis == FlexAuto) {
            item->flexBasis = item->size[node->direction];
        }
        
        if (item->alignSelf == FlexInherit) {
            item->alignSelf = node->alignItems;
        }
        
        setupProperties(item);
    }
}

void layoutFlexNode(FlexNode* node, float constraintedWidth, float constraintedHeight) {
    setupProperties(node);
    FlexSize constraintedSize;
    constraintedSize.size[FLEX_WIDTH] = constraintedWidth == FlexInfinite ? FlexInfinite : (constraintedWidth - getMargin(node, FLEX_WIDTH));
    constraintedSize.size[FLEX_HEIGHT] = constraintedHeight == FlexInfinite ? FlexInfinite : (constraintedHeight - getMargin(node, FLEX_HEIGHT));
    _layoutFlexNode(node, constraintedSize, true);
    node->result.position[FLEX_LEFT] = node->result.margin[FLEX_LEFT];
    node->result.position[FLEX_TOP] = node->result.margin[FLEX_TOP];
}

void initFlexNode(FlexNode* node) {
    node->fixed = false;
    node->wrap = false;
    node->direction = FlexHorizontal;
    node->alignItems = FlexStretch;
    node->alignSelf = FlexInherit;
    node->alignContent = FlexStretch;
    node->justifyContent = FlexStart;
    node->flexBasis = FlexAuto;
    node->flexGrow  = 0;
    node->flexShrink = 1;
    node->size[FLEX_WIDTH] = FlexAuto;
    node->size[FLEX_HEIGHT] = FlexAuto;
    node->minSize[FLEX_WIDTH] = 0;
    node->minSize[FLEX_HEIGHT] = 0;
    node->maxSize[FLEX_WIDTH] = FlexInfinite;
    node->maxSize[FLEX_HEIGHT] = FlexInfinite;
    node->margin[FLEX_LEFT] = 0;
    node->margin[FLEX_TOP] = 0;
    node->margin[FLEX_RIGHT] = 0;
    node->margin[FLEX_BOTTOM] = 0;
    node->padding[FLEX_LEFT] = 0;
    node->padding[FLEX_TOP] = 0;
    node->padding[FLEX_RIGHT] = 0;
    node->padding[FLEX_BOTTOM] = 0;
    node->border[FLEX_LEFT] = 0;
    node->border[FLEX_TOP] = 0;
    node->border[FLEX_RIGHT] = 0;
    node->border[FLEX_BOTTOM] = 0;
    node->spacing = 0;
    node->lineSpacing = 0;
}
