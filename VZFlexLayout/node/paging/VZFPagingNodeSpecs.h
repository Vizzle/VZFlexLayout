//
//  VZFPagingNodeSpecs.h
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"
#import "VZFLength.h"
#import "VZFActionWrapper.h"

namespace VZ {
    
    typedef enum {
        PagingHorizontal,
        PagingVertical
    } PagingDirection;
    
    namespace PagingNodeSpecsDefault{
        extern bool scrollEnabled;
        extern bool paging;
        extern FlexLength margin;
        extern float pageControlScale;
        extern float animationDuration;
    }
    
    struct PagingNodeSpecs{
        PagingDirection direction;
        Value<bool, PagingNodeSpecsDefault::scrollEnabled> scrollEnabled;
        Value<bool, PagingNodeSpecsDefault::scrollEnabled> paging;
        float autoScroll;   // 自动滚动的时间间隔，为 0 表示不自动滚动
        bool infiniteLoop;  // 是否循环滚动
        Value<float, PagingNodeSpecsDefault::animationDuration> animationDuration;  // 自动滚动的动画时长
        
        bool pageControl;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginLeft;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginRight;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginTop;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginBottom;
        Value<float, PagingNodeSpecsDefault::pageControlScale> pageControlScale;
        UIColor* pageControlColor;
        UIColor* pageControlSelectedColor;
        
        VZFBlockAction* switched;
        
        const PagingNodeSpecs copy() const{
            return {direction, scrollEnabled,paging,autoScroll,infiniteLoop,animationDuration,pageControl,pageControlMarginLeft,pageControlMarginRight,pageControlMarginTop,pageControlMarginBottom,pageControlScale,pageControlColor,pageControlSelectedColor };
        }
        
        bool operator == (const PagingNodeSpecs &other) const {
            return (direction == other.direction
                    && scrollEnabled == other.scrollEnabled
                    && paging == other.paging
                    && autoScroll == other.autoScroll
                    && infiniteLoop == other.infiniteLoop
                    && pageControl == other.pageControl
                    && pageControlMarginLeft == other.pageControlMarginLeft
                    && pageControlMarginRight == other.pageControlMarginRight
                    && pageControlMarginTop == other.pageControlMarginTop
                    && pageControlMarginBottom == other.pageControlMarginBottom
                    && pageControlScale == other.pageControlScale
                    && pageControlColor == other.pageControlColor
                    && pageControlSelectedColor == other.pageControlSelectedColor);
        }
        
        size_t hash() const;
        
    };
    
    
}
