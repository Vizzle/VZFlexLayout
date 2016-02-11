
#include "FlexLayout.h"
#include "Macros.h"

#include <string>
#include <cassert>
#include <map>

namespace flex {
    
    namespace Defaults {
    
#define PROPERTY(CLASS, NAME, DEFAULT, ...) CLASS NAME = DEFAULT;
        PROPERTIES
#undef  PROPERTY
    }
    
    std::vector<std::shared_ptr<BaseProperty>> flex_properties = {
#define PROPERTY(CLASS, NAME, DEFAULT, ...) std::shared_ptr<Property<CLASS, std::is_enum<CLASS>::value>>(new Property<CLASS, std::is_enum<CLASS>::value>(#NAME, offsetof(FlexLayout, NAME), Defaults::NAME, __VA_ARGS__)),
        PROPERTIES
#undef  PROPERTY
    };
    
    static int totalCall = 0;
    
    Float clamp(Float value, Float min, Float max) {
        if (max == flex::Infinite) {
            return std::max(value, min);
        } else {
            return std::max(std::min(value, max), min);
        }
    }
    
    Float clamp(Float value, Float max) {
        if (max == flex::Infinite) {
            return value;
        } else {
            return std::min(value, max);
        }
    }
    
    std::string str(Float size) {
        if (size == flex::Undefined) {
            return "undefined";
        } else if (size == flex::Infinite) {
            return "infinite";
        } else if (size == flex::Auto) {
            return "auto";
        } else if (size == flex::Content) {
            return "content";
        } else if (size == flex::Infinite) {
            return "none";
        } else {
            return std::to_string(size);
        }
    }
    
    // this class is used to add member methods to FlexLayout, SHOULD NOT add any other fields or virtual methods.
    struct FlexLayoutHelper : public FlexLayout {
        FlexLayoutHelper() = delete;
        
        void setupProperties() {
            // assertions
            assert(width.value >= 0 || width.value == flex::Auto);
            assert(height.value >= 0 || height.value == flex::Auto);
            assert(minWidth >= 0);
            assert(minHeight >= 0);
            assert(maxWidth >= 0 || maxWidth == flex::Infinite);
            assert(maxHeight >= 0 || maxHeight == flex::Infinite);
            assert(flexBasis.value >= 0 || flexBasis.value == flex::Auto || flexBasis.value == flex::Content);
//            assert(content.node == nullptr || children.empty());
            
            // set up margin & padding
            if (marginTop != flex::Undefined) margin.top = marginTop;
            if (marginRight != flex::Undefined) margin.right = marginRight;
            if (marginBottom != flex::Undefined) margin.bottom = marginBottom;
            if (marginLeft != flex::Undefined) margin.left = marginLeft;
            if (paddingTop != flex::Undefined) padding.top = paddingTop;
            if (paddingRight != flex::Undefined) padding.right = paddingRight;
            if (paddingBottom != flex::Undefined) padding.bottom = paddingBottom;
            if (paddingLeft != flex::Undefined) padding.left = paddingLeft;
            if (alignItems == FlexAlign::Auto) alignItems = FlexAlign::Stretch;
            
            if (margin.left != flex::Auto) result.marginLeft = margin.left;
            if (margin.top != flex::Auto) result.marginTop = margin.top;
            if (margin.bottom != flex::Auto) result.marginBottom = margin.bottom;
            if (margin.right != flex::Auto) result.marginRight = margin.right;
            result.paddingLeft = padding.left;
            result.paddingTop = padding.top;
            result.paddingBottom = padding.bottom;
            result.paddingRight = padding.right;
            
            for (FlexLayout& _item : children) {
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                
                if (item.flexBasis.value == flex::Content) {
                    item.flexBasis = Length(flex::Auto);
                } else if (item.flexBasis.value == flex::Auto) {
                    item.flexBasis = childMainSize(item);
                }
                
                if (item.alignSelf == FlexAlign::Auto) {
                    item.alignSelf = alignItems;
                }
                
                item.setupProperties();
            }
        }
        
        bool isVertical() const {
            return direction == FlexDirection::Vertical;
        }
        
        bool isHorizontal() const {
            return direction == FlexDirection::Horizontal;
        }
        
        Length mainSize() const { return isVertical() ? (Length)height : (Length)width; }
        Length& mainSize() { return isVertical() ? (Length&)height : (Length&)width; }
        
        Length crossSize() const { return isVertical() ? (Length)width : (Length)height; }
        Length& crossSize() { return isVertical() ? (Length&)width : (Length&)height; }
        
        Float minMainSize() const { return isVertical() ? (Float)minHeight : (Float)minWidth; }
        
        Float minCrossSize() const { return isVertical() ? (Float)minWidth : (Float)minHeight; }
        
        Float maxMainSize() const { return isVertical() ? (Float)maxHeight : (Float)maxWidth; }
        
        Float maxCrossSize() const { return isVertical() ? (Float)maxWidth : (Float)maxHeight; }
        
        Float resultMainPosition() const { return isVertical() ? result.top : result.left; }
        Float& resultMainPosition() { return isVertical() ? result.top : result.left; }
        
        Float resultCrossPosition() const { return isVertical() ? result.left : result.top; }
        Float& resultCrossPosition() { return isVertical() ? result.left : result.top; }
        
        Float resultMainSize() const { return isVertical() ? result.height : result.width; }
        Float& resultMainSize() { return isVertical() ? result.height : result.width; }
        
        Float resultCrossSize() const { return isVertical() ? result.width : result.height; }
        Float& resultCrossSize() { return isVertical() ? result.width : result.height; }
        
        Length childMainSize(const FlexLayout& child) const { return isVertical() ? (Length)child.height : (Length)child.width; }
        Length& childMainSize(FlexLayout& child) { return isVertical() ? (Length&)child.height.value : (Length&)child.width.value; }
        
        Length childCrossSize(const FlexLayout& child) const { return isVertical() ? (Length)child.width : (Length)child.height; }
        Length& childCrossSize(FlexLayout& child) { return isVertical() ? (Length&)child.width.value : (Length&)child.height.value; }
        
        Float childMinMainSize(const FlexLayout& child) const { return isVertical() ? (Float)child.minHeight : (Float)child.minWidth; }
        
        Float childMinCrossSize(const FlexLayout& child) const { return isVertical() ? (Float)child.minWidth : (Float)child.minHeight; }
        
        Float childMaxMainSize(const FlexLayout& child) const { return isVertical() ? (Float)child.maxHeight : (Float)child.maxWidth; }
        
        Float childMaxCrossSize(const FlexLayout& child) const { return isVertical() ? (Float)child.maxWidth : (Float)child.maxHeight; }
        
        Float childResultMainSize(const FlexLayout& child) const { return isVertical() ? child.result.height : child.result.width; }
        Float& childResultMainSize(FlexLayout& child) { return isVertical() ? child.result.height : child.result.width; }
        
        Float childResultCrossSize(const FlexLayout& child) const { return isVertical() ? child.result.width : child.result.height; }
        Float& childResultCrossSize(FlexLayout& child) { return isVertical() ? child.result.width : child.result.height; }
        
        Float childResultMainPosition(FlexLayout& child) const { return isVertical() ? child.result.top : child.result.left; }
        Float& childResultMainPosition(FlexLayout& child) { return isVertical() ? child.result.top : child.result.left; }
        
        Float childResultCrossPosition(FlexLayout& child) const { return isVertical() ? child.result.left : child.result.top; }
        Float& childResultCrossPosition(FlexLayout& child) { return isVertical() ? child.result.left : child.result.top; }
        
        Float availableWidth(Float constraintedWidth) const {
            return width.isAbsolute() ? width.absoluteValue() - padding.width() - borderWidth * 2
            : constraintedWidth == flex::Infinite ? flex::Infinite
            : (constraintedWidth - margin.width() - padding.width() - borderWidth * 2);
        }
        
        Float availableHeight(Float constraintedHeight) const {
            return height.isAbsolute() ? height.absoluteValue() - padding.height() - borderWidth * 2
            : constraintedHeight == flex::Infinite ? flex::Infinite
            : (constraintedHeight - margin.height() - padding.height() - borderWidth * 2);
        }
        
        Size availableSize(Size constraintedSize) const {
            return { availableWidth(constraintedSize.width), availableHeight(constraintedSize.height) };
        }
        
        Float availableMainSize(Size constraintedSize) {
            return isVertical() ? availableHeight(constraintedSize.height) : availableWidth(constraintedSize.width);
        }
        
        Float availableCrossSize(Size constraintedSize) {
            return isHorizontal() ? availableHeight(constraintedSize.height) : availableWidth(constraintedSize.width);
        }
        
        Float mainPadding() const { return isVertical() ? padding.height() : padding.width(); }
        
        Float crossPadding() const { return isVertical() ? padding.width() : padding.height(); }
        
        Float mainPaddingStart() const { return isVertical() ? padding.top : padding.left; }
        
        Float mainPaddingEnd() const { return isVertical() ? padding.bottom : padding.right; }
        
        Float crossPaddingStart() const { return isVertical() ? padding.left : padding.top; }
        
        Float crossPaddingEnd() const { return isVertical() ? padding.right : padding.bottom; }
        
        Float mainMargin() const { return isVertical() ? margin.height() : margin.width(); }
        
        Float crossMargin() const { return isVertical() ? margin.width() : margin.height(); }
        
        Float mainMarginStart() const { return isVertical() ? margin.top : margin.left; }
        Float& mainMarginStart() { return isVertical() ? margin.top : margin.left; }
        
        Float mainMarginEnd() const { return isVertical() ? margin.bottom : margin.right; }
        Float& mainMarginEnd() { return isVertical() ? margin.bottom : margin.right; }
        
        Float crossMarginStart() const { return isVertical() ? margin.left : margin.top; }
        Float& crossMarginStart() { return isVertical() ? margin.left : margin.top; }
        
        Float crossMarginEnd() const { return isVertical() ? margin.right : margin.bottom; }
        Float& crossMarginEnd() { return isVertical() ? margin.right : margin.bottom; }
        
        Float childMainMargin(const FlexLayout& child) const { return isVertical() ? child.margin.height() : child.margin.width(); }
        
        Float childCrossMargin(const FlexLayout& child) const { return isVertical() ? child.margin.width() : child.margin.height(); }
        
        Float childMainMarginStart(const FlexLayout& child) const { return isVertical() ? child.margin.top : child.margin.left; }
        Float& childMainMarginStart(FlexLayout& child) { return isVertical() ? child.margin.top : child.margin.left; }
        
        Float childMainMarginEnd(const FlexLayout& child) const { return isVertical() ? child.margin.bottom : child.margin.right; }
        Float& childMainMarginEnd(FlexLayout& child) { return isVertical() ? child.margin.bottom : child.margin.right; }
        
        Float childCrossMarginStart(const FlexLayout& child) const { return isVertical() ? child.margin.left : child.margin.top; }
        Float& childCrossMarginStart(FlexLayout& child) { return isVertical() ? child.margin.left : child.margin.top; }
        
        Float childCrossMarginEnd(const FlexLayout& child) const { return isVertical() ? child.margin.right : child.margin.bottom; }
        Float& childCrossMarginEnd(FlexLayout& child) { return isVertical() ? child.margin.right : child.margin.bottom; }
        
        Float childResultMainMargin(const FlexLayout& child) const { return isVertical() ? (child.result.marginTop + child.result.marginBottom) : (child.result.marginLeft + child.result.marginRight); }
        
        Float childResultCrossMargin(const FlexLayout& child) const { return isVertical() ? (child.result.marginLeft + child.result.marginRight) : (child.result.marginTop + child.result.marginBottom); }
        
        Float childResultMainMarginStart(const FlexLayout& child) const { return isVertical() ? child.result.marginTop : child.result.marginLeft; }
        Float& childResultMainMarginStart(FlexLayout& child) { return isVertical() ? child.result.marginTop : child.result.marginLeft; }
        
        Float childResultMainMarginEnd(const FlexLayout& child) const { return isVertical() ? child.result.marginBottom : child.result.marginRight; }
        Float& childResultMainMarginEnd(FlexLayout& child) { return isVertical() ? child.result.marginBottom : child.result.marginRight; }
        
        Float childResultCrossMarginStart(const FlexLayout& child) const { return isVertical() ? child.result.marginLeft : child.result.marginTop; }
        Float& childResultCrossMarginStart(FlexLayout& child) { return isVertical() ? child.result.marginLeft : child.result.marginTop; }
        
        Float childResultCrossMarginEnd(const FlexLayout& child) const { return isVertical() ? child.result.marginRight : child.result.marginBottom; }
        Float& childResultCrossMarginEnd(FlexLayout& child) { return isVertical() ? child.result.marginRight : child.result.marginBottom; }
        
        bool childMainMarginHasAuto(const FlexLayout& child) const {
            return isVertical() ? (child.margin.top == flex::Auto || child.margin.bottom == flex::Auto) : (child.margin.left == flex::Auto || child.margin.right == flex::Auto);
        }
        
        bool childCrossMarginHasAuto(const FlexLayout& child) const {
            return isVertical() ? (child.margin.left == flex::Auto || child.margin.right == flex::Auto) : (child.margin.top == flex::Auto || child.margin.bottom == flex::Auto);
        }
        
        int childrenMainMarginHasAutoCount() const {
            int count = 0;
            for (const FlexLayout& item : children) {
                if (item.fixed) continue;
                if (childMainMarginStart(item) == flex::Auto) count++;
                if (childMainMarginEnd(item) == flex::Auto) count++;
            }
            return count;
        }
        
        int childrenCrossMarginHasAutoCount() const {
            int count = 0;
            for (const FlexLayout& item : children) {
                if (item.fixed) continue;
                if (childCrossMarginStart(item) == flex::Auto) count++;
                if (childCrossMarginEnd(item) == flex::Auto) count++;
            }
            return count;
        }
        
        Size sizeFromLogicSize(Float mainSize, Float crossSize) const {
            return isVertical() ? Size{crossSize, mainSize} : Size{mainSize, crossSize};
        }
        
        void layout(Size constraintedSize, bool fill = false) {
            totalCall++;
            if (fill && width.isAuto() && constraintedSize.width != flex::Infinite) {
                width = Length(constraintedSize.width);
            }
            
            constraintedSize.width = constraintedSize.width == flex::Infinite ? flex::Infinite : std::max((Float)0, constraintedSize.width);
            constraintedSize.height = constraintedSize.height == flex::Infinite ? flex::Infinite : std::max((Float)0, constraintedSize.height);
            
            if (width.isAbsolute() || width.isPercent()) {
                result.width = clamp(width.isPercent() ? constraintedSize.width * width.value : width.absoluteValue(), minWidth, maxWidth);
            }
            if (height.isAbsolute() || height.isPercent()) {
                result.height = clamp(height.isPercent() ? constraintedSize.height * height.value : height.absoluteValue(), minHeight, maxHeight);
            }
            
            // measure non-container element
            if (children.empty() && content.node) {
                if (width.isAuto() || height.isAuto()) {
                    Size size = content.node->sizeThatFits(Size{width.isAuto() ? (constraintedSize.width != flex::Infinite ? constraintedSize.width - padding.width() - 2 * borderWidth : FLT_MAX) : result.width,
                        height.isAuto() ? (constraintedSize.height != flex::Infinite ? constraintedSize.height - padding.height() - 2 * borderWidth : FLT_MAX) : result.height});
                    if (width.isAuto()) {
                        result.width = clamp(size.width + padding.width() + borderWidth * 2, minWidth, maxWidth);
                    }
                    if (height.isAuto()) {
                        result.height = clamp(size.height + padding.height() + borderWidth * 2, minHeight, maxHeight);
                    }
                }
                return;
            } else if (children.empty()) {
                if (width.isAuto()) {
                    result.width = clamp(padding.width() + borderWidth * 2, minWidth, maxWidth);
                }
                if (height.isAuto()) {
                    result.height = clamp(padding.height() + borderWidth * 2, minHeight, maxHeight);
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
            /* currently just supports fixed border */
            // TODO redundant calculation
            Size availableSize = this->availableSize(constraintedSize);
            Float availableMainSize = this->availableMainSize(constraintedSize);
            Float availableCrossSize = this->availableCrossSize(constraintedSize);
            
            Float itemsMainSize = 0;
            Float itemsCrossSize = 0;
            Float fixedItemsCount = 0;
            
            // 3. Determine the flex base size and hypothetical main size of each item:
            for (FlexLayout& _item : children) {
                if (_item.fixed) {
                    fixedItemsCount++;
                    continue;
                }
                
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                Float itemBaseSize;
                Float itemHypotheticalMainSize;
                
                // A. If the item has a definite used flex basis, that’s the flex base size.
                if (item.flexBasis.isAbsolute()) {
                    itemBaseSize = item.flexBasis.absoluteValue();
                } else if (item.flexBasis.isPercent()) {
                    // FIXME availableMainSize may be infinite
                    itemBaseSize = item.flexBasis.value * availableMainSize;
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
                    auto oldMainSize = childMainSize(item);
                    childMainSize(item) = item.flexBasis;
                    item.layout(availableSize/* - (isVertical() ? Size{0, itemsMainSize} : Size{itemsMainSize, 0})*/);
                    childMainSize(item) = oldMainSize;
                    itemBaseSize = childResultMainSize(item);
                }
                
                item.flexBasis = Length(itemBaseSize);
                
                // When determining the flex base size, the item’s min and max main size properties are ignored (no clamping occurs).
                // The hypothetical main size is the item’s flex base size clamped according to its min and max main size properties.
                itemHypotheticalMainSize = clamp(itemBaseSize, childMinMainSize(item), childMaxMainSize(item));
                childResultMainSize(item) = itemHypotheticalMainSize;
                
                ///////////////////////////////////////////////////////////////////////////
                //  Main Size Determination
                
                // 5. Collect flex items into flex lines:
                //     * If the flex container is single-line, collect all the flex items into a single flex line.
                //     * Otherwise, starting from the first uncollected item, collect consecutive items one by one until the first time that the next collected item would not fit into the flex container’s inner main size (or until a forced break is encountered, see §10 Fragmenting Flex Layout). If the very first uncollected item wouldn’t fit, collect just it into the line.
                //       For this step, the size of a flex item is its outer hypothetical main size.
                //       Repeat until all flex items have been collected into flex lines.
                //       > Note that the "collect as many" line will collect zero-sized flex items onto the end of the previous line even if the last non-zero item exactly "filled up" the line.
                /* currently only support single-line */
                itemsMainSize += itemHypotheticalMainSize + childMainMargin(item);
            }
            
            // > Note: spacing property is not in the css specification, it's an extra property to determine the spacing between items in the main axis.
            Float itemsSpacing = spacing * (children.size() - fixedItemsCount - 1);
            itemsMainSize += itemsSpacing;
            
            // 4. Determine the main size of the flex container using the rules of the formatting context in which it participates. For this computation, auto margins on flex items are treated as 0.
            Float mainConstraintedSize = isVertical() ? constraintedSize.height : constraintedSize.width;
            resultMainSize() = mainSize().isAbsolute() ? mainSize().absoluteValue() : mainSize().isPercent() ? mainSize().value * availableMainSize : clamp(itemsMainSize + mainPadding() + borderWidth * 2, mainConstraintedSize != flex::Infinite ? mainConstraintedSize - mainMargin() : flex::Infinite);
            
            // 6. Resolve the flexible lengths of all the flex items to find their used main size (see section 9.7.).
            std::vector<FlexLayoutHelper*> frozenItems, unfrozenItems;
            
            // 6.1 Determine the used flex factor. Sum the outer hypothetical main sizes of all items on the line. If the sum is less than the flex container’s inner main size, use the flex grow factor for the rest of this algorithm; otherwise, use the flex shrink factor.
            bool usingFlexGrowFactor = itemsMainSize < availableMainSize;
            Float innerMainSize = resultMainSize() - mainPadding() - borderWidth * 2;
            Float initialFreeSpace = innerMainSize - itemsSpacing;
            
            for (FlexLayout& _item : children) {
                if (_item.fixed) continue;
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                // 6.2 Size inflexible items. Freeze, setting its target main size to its hypothetical main size…
                //       * any item that has a flex factor of zero
                //       * if using the flex grow factor: any item that has a flex base size greater than its hypothetical main size
                //       * if using the flex shrink factor: any item that has a flex base size smaller than its hypothetical main size
                // 6.3 Calculate initial free space. Sum the outer sizes of all items on the line, and subtract this from the flex container’s inner main size. For frozen items, use their outer target main size; for other items, use their outer flex base size.
                if ((usingFlexGrowFactor ? (Float)item.flexGrow : (Float)item.flexShrink * item.flexBasis.absoluteValue()) == 0
                    || (usingFlexGrowFactor && item.flexBasis.absoluteValue() > childResultMainSize(item))
                    || (!usingFlexGrowFactor && item.flexBasis.absoluteValue() < childResultMainSize(item))) {
                    frozenItems.push_back(&item);
                    initialFreeSpace -= childResultMainSize(item) + childMainMargin(item);
                } else {
                    unfrozenItems.push_back(&item);
                    initialFreeSpace -= item.flexBasis.absoluteValue() + childMainMargin(item);
                }
            }
            
            // 6.4 Loop:
            while (true) {
                // a. Check for flexible items. If all the flex items on the line are frozen, free space has been distributed; exit this loop.
                if (unfrozenItems.empty()) {
                    break;
                }
                
                // b. Calculate the remaining free space as for initial free space, above. If the sum of the unfrozen flex items’ flex factors is less than one, multiply the initial free space by this sum. If the magnitude of this value is less than the magnitude of the remaining free space, use this as the remaining free space.
                Float remainingFreeSpace = std::max((Float)0, innerMainSize - itemsSpacing);
                Float unFrozenFlexFactors = 0;
                
                for (auto item : frozenItems) {
                    remainingFreeSpace -= childResultMainSize(*item) + childMainMargin(*item);
                }
                for (auto item : unfrozenItems) {
                    remainingFreeSpace -= item->flexBasis.absoluteValue() + childMainMargin(*item);
                    unFrozenFlexFactors += usingFlexGrowFactor ? (Float)item->flexGrow : (Float)item->flexShrink;
                }
                
                if (unFrozenFlexFactors < 1) {
                    Float value = initialFreeSpace * unFrozenFlexFactors;
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
                else if (usingFlexGrowFactor) {
                    for (auto item : unfrozenItems) {
                        Float ratio = item->flexGrow / unFrozenFlexFactors;
                        childResultMainSize(*item) = item->flexBasis.absoluteValue() + remainingFreeSpace * ratio;
                    }
                }
                //    If using the flex shrink factor
                //         For every unfrozen item on the line, multiply its flex shrink factor by its inner flex base size, and note this as its scaled flex shrink factor. Find the ratio of the item’s scaled flex shrink factor to the sum of the scaled flex shrink factors of all unfrozen items on the line. Set the item’s target main size to its flex base size minus a fraction of the absolute value of the remaining free space proportional to the ratio. Note this may result in a negative inner main size; it will be corrected in the next step.
                else {
                    Float unFrozenScaledFlexFactors = 0;
                    for (auto item : unfrozenItems) {
                        unFrozenScaledFlexFactors += item->flexShrink * item->flexBasis.absoluteValue();
                    }
                    for (auto item : unfrozenItems) {
                        Float ratio = item->flexShrink * item->flexBasis.absoluteValue() / unFrozenScaledFlexFactors;
                        childResultMainSize(*item) = item->flexBasis.absoluteValue() + remainingFreeSpace * ratio;
                    }
                }
                //    Otherwise
                //         Do nothing.
                
                // d. Fix min/max violations. Clamp each non-frozen item’s target main size by its min and max main size properties. If the item’s target main size was made smaller by this, it’s a max violation. If the item’s target main size was made larger by this, it’s a min violation.
                std::vector<char> violations;
                Float totalViolation = 0;
                for (auto item : unfrozenItems) {
                    Float& targetMainSize = childResultMainSize(*item);
                    Float clampedSize = clamp(targetMainSize, childMinMainSize(*item), childMaxMainSize(*item));
                    violations.push_back(clampedSize == targetMainSize ? 0 : clampedSize < targetMainSize ? 1 : -1);    // 1/-1 means max/min
                    totalViolation += clampedSize - targetMainSize;
                    targetMainSize = clampedSize;
                }
                
                // e. Freeze over-flexed items. The total violation is the sum of the adjustments from the previous step ∑(clamped size - unclamped size). If the total violation is:
                //    Zero
                //         Freeze all items.
                if (totalViolation == 0) {
                    frozenItems.insert(frozenItems.end(), unfrozenItems.begin(), unfrozenItems.end());
                    unfrozenItems.clear();
                }
                //    Positive
                //         Freeze all the items with min violations.
                else if (totalViolation > 0) {
                    for (int i=0, j=0;i<unfrozenItems.size();i++,j++) {
                        if (violations[j] < 0) {
                            frozenItems.push_back(unfrozenItems[i]);
                            unfrozenItems.erase(unfrozenItems.begin() + i);
                            i--;
                        }
                    }
                }
                //    Negative
                //         Freeze all the items with max violations.
                else {
                    for (int i=0, j=0;i<unfrozenItems.size();i++,j++) {
                        if (violations[j] > 0) {
                            frozenItems.push_back(unfrozenItems[i]);
                            unfrozenItems.erase(unfrozenItems.begin() + i);
                            i--;
                        }
                    }
                }
                
                // f. Return to the start of this loop.
            }
            
            ///////////////////////////////////////////////////////////////////////////
            //  Cross Size Determination
            
            // 7. Determine the hypothetical cross size of each item by performing layout with the used main size and the available space, treating auto as fit-content.
            for (FlexLayout& _item : children) {
                if (_item.fixed) continue;
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                auto oldMainSize = childMainSize(item);
                childMainSize(item) = childResultMainSize(item);
                item.layout(sizeFromLogicSize(childResultMainSize(item), availableCrossSize));
                childMainSize(item) = oldMainSize;
            }
            
            // 8. Calculate the cross size of each flex line.
            //    If the flex container is single-line and has a definite cross size, the cross size of the flex line is the flex container’s inner cross size.
            if (crossSize().isAbsolute()) {
                itemsCrossSize = crossSize().absoluteValue() - crossPadding() - borderWidth * 2;
            } else if (crossSize().isPercent()) {
                itemsCrossSize = crossSize().value * availableCrossSize - crossPadding() - borderWidth * 2;
            }
            //Otherwise, for each flex line:
            //    1. Collect all the flex items whose inline-axis is parallel to the main-axis, whose align-self is baseline, and whose cross-axis margins are both non-auto. Find the largest of the distances between each item’s baseline and its hypothetical outer cross-start edge, and the largest of the distances between each item’s baseline and its hypothetical outer cross-end edge, and sum these two values.
            /* baseline not supported yet */
            //    2. Among all the items not collected by the previous step, find the largest outer hypothetical cross size.
            //    3. The used cross-size of the flex line is the largest of the numbers found in the previous two steps and zero.
            //       If the flex container is single-line, then clamp the line’s cross-size to be within the container’s computed min and max cross-size properties. Note that if CSS 2.1’s definition of min/max-width/height applied more generally, this behavior would fall out automatically.
            else {
                for (FlexLayout& _item : children) {
                    if (_item.fixed) continue;
                    FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                    Float itemOuterCrossSize = childResultCrossSize(item) + childCrossMargin(item);
                    if (itemOuterCrossSize > itemsCrossSize) {
                        itemsCrossSize = itemOuterCrossSize;
                    }
                }
            }
            
            // 9. Handle 'align-content: stretch'. If the flex container has a definite cross size, align-content is stretch, and the sum of the flex lines' cross sizes is less than the flex container’s inner cross size, increase the cross size of each flex line by equal amounts such that the sum of their cross sizes exactly equals the flex container’s inner cross size.
            /* only supports single-line yet */
            
            // 10. Collapse visibility:collapse items. If any flex items have visibility: collapse, note the cross size of the line they’re in as the item’s strut size, and restart layout from the beginning.
            //     In this second layout round, when collecting items into lines, treat the collapsed items as having zero main size. For the rest of the algorithm following that step, ignore the collapsed items entirely (as if they were display:none) except that after calculating the cross size of the lines, if any line’s cross size is less than the largest strut size among all the collapsed items in the line, set its cross size to that strut size.
            //     Skip this step in the second layout round.
            // TODO supports visibility property ?
            
            // 11. Determine the used cross size of each flex item. If a flex item has align-self: stretch, its computed cross size property is auto, and neither of its cross-axis margins are auto, the used outer cross size is the used cross size of its flex line, clamped according to the item’s min and max cross size properties. Otherwise, the used cross size is the item’s hypothetical cross size.
            //     If the flex item has align-self: stretch, redo layout for its contents, treating this used size as its definite cross size so that percentage-sized children can be resolved.
            //     > Note that this step does not affect the main size of the flex item, even if it has an intrinsic aspect ratio.
            for (FlexLayout& _item : children) {
                if (_item.fixed) continue;
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                auto oldCrossSize = childCrossSize(item);
                if (item.alignSelf == FlexAlign::Stretch && childCrossSize(item) == flex::Auto && !childCrossMarginHasAuto(item)) {
                    childCrossSize(item) = childResultCrossSize(item) = itemsCrossSize - childCrossMargin(item);
                }
                
                childResultCrossSize(item) = clamp(childResultCrossSize(item), childMinCrossSize(item), childMaxCrossSize(item));
                
                if (item.alignSelf == FlexAlign::Stretch) {
                    auto oldMainSize = childMainSize(item);
                    childCrossSize(item) = childResultCrossSize(item);
                    childMainSize(item) = childResultMainSize(item);
                    item.layout(availableSize);
                    childMainSize(item) = oldMainSize;
                }
                childCrossSize(item) = oldCrossSize;
            }
            
            ///////////////////////////////////////////////////////////////////////////
            //  Main-Axis Alignment
            
            itemsMainSize = 0;
            for (FlexLayout& _item : children) {
                if (_item.fixed) continue;
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                itemsMainSize += childResultMainSize(item) + childMainMargin(item);
            }
            itemsMainSize += itemsSpacing;
            // 12. Distribute any remaining free space. For each flex line:
            Float remainMainSize = resultMainSize() - mainPadding() - borderWidth * 2 - itemsMainSize;
            //       1. If the remaining free space is positive and at least one main-axis margin on this line is auto, distribute the free space equally among these margins.
            if (remainMainSize > 0) {
                int count = childrenMainMarginHasAutoCount();
                if (count > 0) {
                    Float autoMargin = remainMainSize / count;
                    remainMainSize = 0;
                    for (FlexLayout& _item : children) {
                        if (_item.fixed) continue;
                        FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                        if (childMainMarginStart(item) == flex::Auto) childResultMainMarginStart(item) = autoMargin;
                        if (childMainMarginEnd(item) == flex::Auto) childResultMainMarginEnd(item) = autoMargin;
                    }
                }
            }
            //          Otherwise, set all auto margins to zero.
            else {
                for (FlexLayout& _item : children) {
                    if (_item.fixed) continue;
                    FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                    if (childMainMarginStart(item) == flex::Auto) childResultMainMarginStart(item) = 0;
                    if (childMainMarginEnd(item) == flex::Auto) childResultMainMarginEnd(item) = 0;
                }
            }
            
            //       2. Align the items along the main-axis per justify-content.
            Float offsetStart;
            Float offsetStep;
            switch (justifyContent) {
                case FlexJustify::Start:
                    offsetStart = 0;
                    offsetStep = 0;
                    break;
                case FlexJustify::Center:
                    offsetStart = remainMainSize / 2;
                    offsetStep = 0;
                    break;
                case FlexJustify::End:
                    offsetStart = remainMainSize;
                    offsetStep = 0;
                    break;
                case FlexJustify::SpaceBetween:
                    offsetStart = 0;
                    offsetStep = remainMainSize / (children.size() - 1);
                    break;
                case FlexJustify::SpaceAround:
                    offsetStep = remainMainSize / children.size();
                    offsetStart = offsetStep / 2;
                    break;
            }
            
            for (FlexLayout& _item : children) {
                if (_item.fixed) continue;
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                offsetStart += childResultMainMarginStart(item);
                childResultMainPosition(item) = offsetStart;
                offsetStart += childResultMainSize(item) + childResultMainMarginEnd(item) + offsetStep + spacing;
                
                ///////////////////////////////////////////////////////////////////////////
                //  Cross-Axis Alignment
                
                // 13. Resolve cross-axis auto margins. If a flex item has auto cross-axis margins:
                //       * If its outer cross size (treating those auto margins as zero) is less than the cross size of its flex line, distribute the difference in those sizes equally to the auto margins.
                Float remindCrossSize = itemsCrossSize - (childResultCrossSize(item) + childCrossMargin(item));
                if (remindCrossSize > 0) {
                    if (childCrossMarginStart(item) == flex::Auto && childCrossMarginEnd(item) == flex::Auto) {
                        childResultCrossMarginStart(item) = childResultCrossMarginEnd(item) = remindCrossSize / 2;
                    } else if (childCrossMarginStart(item) == flex::Auto) {
                        childResultCrossMarginStart(item) = remindCrossSize;
                    } else if (childCrossMarginEnd(item) == flex::Auto) {
                        childResultCrossMarginEnd(item) = remindCrossSize;
                    }
                }
                //       * Otherwise, if the block-start or inline-start margin (whichever is in the cross axis) is auto, set it to zero. Set the opposite margin so that the outer cross size of the item equals the cross size of its flex line.
                else {
                    if (childCrossMarginStart(item) == flex::Auto) {
                        childResultCrossMarginStart(item) = 0;
                    }
                    childResultCrossMarginEnd(item) = itemsCrossSize - (childResultCrossSize(item) + childResultCrossMarginStart(item));
                }
                
                // 14. Align all flex items along the cross-axis per align-self, if neither of the item’s cross-axis margins are auto.
                remindCrossSize = itemsCrossSize - (childResultCrossSize(item) + childResultCrossMargin(item));
                switch (item.alignSelf) {
                    case FlexAlign::Start:
                        childResultCrossPosition(item) = childResultCrossMarginStart(item);
                        break;
                    case FlexAlign::Center:
                        childResultCrossPosition(item) = childResultCrossMarginStart(item) + remindCrossSize / 2;
                        break;
                    case FlexAlign::End:
                        childResultCrossPosition(item) = childResultCrossMarginStart(item) + remindCrossSize;
                        break;
                    case FlexAlign::Stretch:
                        childResultCrossPosition(item) = childResultCrossMarginStart(item);
                        break;
//                    case FlexAlign::Baseline:
//                        // FIXME not supported yet
//                        assert(false);
//                        break;
                    case FlexAlign::Auto:
                        // all "Auto" value of alignSelf should be replaced by the alignItems of its parent in head of layout
                        assert(false);
                        break;
                }
            }
            
            // 15. Determine the flex container’s used cross size:
            //       * If the cross size property is a definite size, use that, clamped by the min and max cross size properties of the flex container.
            if (!crossSize().isAuto()) {
                
            }
            //       * Otherwise, use the sum of the flex lines' cross sizes, clamped by the min and max cross size properties of the flex container.
            else {
                resultCrossSize() = clamp(itemsCrossSize + crossPadding() + borderWidth * 2, minCrossSize(), maxCrossSize());
            }
            
            Float innerCrossSize = resultCrossSize() - crossPadding() - borderWidth * 2;
            
            // 16. Align all flex lines per align-content.
            /* multi-line not supported yet */
            
            // layout fixed items
            for (FlexLayout& _item : children) {
                if (!_item.fixed) continue;
                FlexLayoutHelper& item = reinterpret_cast<FlexLayoutHelper&>(_item);
                item.layout({result.width, result.height});
                
                Float remindMainSize = innerMainSize - childResultMainSize(item);
                Float remindCrossSize = innerCrossSize - childResultCrossSize(item);
                if (remindMainSize > 0) {
                    if (childMainMarginStart(item) == flex::Auto && childMainMarginEnd(item) == flex::Auto) {
                        childResultMainMarginStart(item) = childResultMainMarginEnd(item) = remindMainSize / 2;
                    } else if (childMainMarginStart(item) == flex::Auto) {
                        childResultMainMarginStart(item) = remindCrossSize;
                    } else if (childMainMarginEnd(item) == flex::Auto) {
                        childResultMainMarginEnd(item) = remindCrossSize;
                    }
                } else {
                    if (childMainMarginStart(item) == flex::Auto) childResultMainMarginStart(item) = 0;
                    if (childMainMarginEnd(item) == flex::Auto) childResultMainMarginEnd(item) = 0;
                }
                
                if (remindCrossSize > 0) {
                    if (childCrossMarginStart(item) == flex::Auto && childCrossMarginEnd(item) == flex::Auto) {
                        childResultCrossMarginStart(item) = childResultCrossMarginEnd(item) = remindCrossSize / 2;
                    } else if (childCrossMarginStart(item) == flex::Auto) {
                        childResultCrossMarginStart(item) = remindCrossSize;
                    } else if (childCrossMarginEnd(item) == flex::Auto) {
                        childResultCrossMarginEnd(item) = remindCrossSize;
                    }
                } else {
                    if (childCrossMarginStart(item) == flex::Auto) {
                        childResultCrossMarginStart(item) = 0;
                    }
                    childResultCrossMarginEnd(item) = itemsCrossSize - (childResultCrossSize(item) + childResultCrossMarginStart(item));
                }
                
                childResultMainPosition(item) = childResultMainMarginStart(item);
                childResultCrossPosition(item) = childResultCrossMarginStart(item);
            }
        }
    };
    
    void copyResult(const FlexLayout& from, FlexLayout& to) {
        to.result = from.result;
        assert(from.children.size() == to.children.size());
        for (int i=0;i<from.children.size();i++) {
            copyResult(from.children[i], to.children[i]);
        }
    }
    
    void layout(FlexLayout& flex, Size constraintedSize) {
        totalCall = 0;
        FlexLayout copy = flex;
        FlexLayoutHelper& layout = reinterpret_cast<FlexLayoutHelper&>(copy);
        layout.setupProperties();
        double t1 = getTime();
        layout.layout({constraintedSize.width == flex::Infinite ? flex::Infinite : constraintedSize.width - layout.margin.width(),
        constraintedSize.height == flex::Infinite ? flex::Infinite : constraintedSize.height - layout.margin.height()}, true);
        double t2 = getTime();
        layout.result.left = layout.result.marginLeft == flex::Auto ? 0 : layout.result.marginLeft;
        layout.result.top = layout.result.marginTop == flex::Auto ? 0 : layout.result.marginTop;
        copyResult(copy, flex);
        printf("calls:%d, time:%lf\n", totalCall, t2-t1);
    }
    
}
