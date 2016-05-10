//
//  VZFScrollNodeSpecs.h
//  O2OReact
//
//  Created by moxin on 16/5/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace VZ {
    
    enum ScrollDirection{
        Vertical,
        Horizontal
    };
    
    struct ScrollNodeSpecs{
        
        
        bool scrollEnabled;
        ScrollDirection direction;
        float spacing;
        bool paging;
        bool autoScroll; //not implemented
        float autoScrollerTimeInterval; //not implemented
        bool infiniteLoop; //not implemented
        
        struct{
            bool enabled;
            float scale;
            float height;
            UIColor* defaultColor;
            UIColor* highlightColor;
        }pageControl; //not implemented
        
        const ScrollNodeSpecs copy() const{
            return {scrollEnabled,direction,spacing,paging,autoScroll, autoScrollerTimeInterval,infiniteLoop,pageControl };
        }
        
        bool operator == (const ScrollNodeSpecs &other) const {
            return (scrollEnabled == other.scrollEnabled
                    && spacing == other.spacing
                    && paging == other.paging
                    && direction == other.direction
                    && autoScroll == other.autoScroll
                    && autoScrollerTimeInterval == other.autoScrollerTimeInterval
                    && infiniteLoop == other.infiniteLoop
                    && pageControl.enabled == other.pageControl.enabled
                    && pageControl.scale == other.pageControl.scale
                    && pageControl.height == other.pageControl.height
                    && pageControl.defaultColor == other.pageControl.defaultColor
                    && pageControl.highlightColor == other.pageControl.highlightColor);
        }
        
        size_t hash() const;
        
    };
    

}
