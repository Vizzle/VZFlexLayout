//
//  VZFScrollNodeSpecs.h
//  O2OReact
//
//  Created by moxin on 16/5/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"

namespace VZ {
    
    typedef enum {
        ScrollNone = 0,
        ScrollVertical = 1 << 0,
        ScrollHorizontal = 1 << 1,
        ScrollBoth = ScrollVertical | ScrollHorizontal
    } ScrollDirection;
    
    namespace DefaultFlexAttributesValue{
        extern ScrollDirection scrollDirection;
        extern bool scrollEnabled;
        extern bool scrollsToTop;
    }
    
    struct ScrollNodeSpecs{
        
        Value<ScrollDirection, DefaultFlexAttributesValue::scrollDirection> scrollDirection;
        Value<bool, DefaultFlexAttributesValue::scrollEnabled> scrollEnabled;
        bool paging;
        Value<bool, DefaultFlexAttributesValue::scrollsToTop> scrollsToTop;

        const ScrollNodeSpecs copy() const{
            return {scrollDirection,scrollEnabled,paging,scrollsToTop};
        }
        
        bool operator == (const ScrollNodeSpecs &other) const {
            return (scrollDirection == other.scrollDirection
                    && scrollEnabled == other.scrollEnabled
                    && paging == other.paging
                    && scrollsToTop == other.scrollsToTop);
        }
        
        size_t hash() const;
        
    };
    

}
