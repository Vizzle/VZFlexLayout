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

namespace VZ {
    
    namespace PagingNodeSpecsDefault{
        extern bool scrollEnabled;
        extern bool paging;
        extern FlexLength margin;
        extern float pageControlScale;
    }
    
    struct PagingNodeSpecs{
        Value<bool, PagingNodeSpecsDefault::scrollEnabled> scrollEnabled;
        Value<bool, PagingNodeSpecsDefault::scrollEnabled> paging;
        float autoScroll;   // 自动滚动的时间间隔，为 0 表示不自动滚动
        bool infiniteLoop;  // 是否循环滚动
        
        bool pageControl;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginLeft;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginRight;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginTop;
        Value<FlexLength, PagingNodeSpecsDefault::margin> pageControlMarginBottom;
        Value<float, PagingNodeSpecsDefault::pageControlScale> pageControlScale;
        UIColor* pageControlColor;
        UIColor* pageControlSelectedColor;
        
        const PagingNodeSpecs copy() const{
            return {scrollEnabled,paging,autoScroll,infiniteLoop,pageControl,pageControlMarginLeft,pageControlMarginRight,pageControlMarginTop,pageControlMarginBottom,pageControlScale,pageControlColor,pageControlSelectedColor };
        }
        
        bool operator == (const PagingNodeSpecs &other) const {
            return (scrollEnabled == other.scrollEnabled
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
