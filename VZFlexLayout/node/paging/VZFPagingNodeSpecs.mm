//
//  VZFPagingNodeSpecs.m
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFPagingNodeSpecs.h"

namespace VZ {
    
    namespace PagingNodeSpecsDefault{
        bool scrollEnabled = true;
        bool paging = true;
        FlexLength margin = FlexLengthAuto;
        float pageControlScale = 1;
        float animationDuration = 0.3;
    }
    
    size_t PagingNodeSpecs::hash() const{
        NSUInteger subhashes[] = {
            std::hash<bool>()(scrollEnabled),
            std::hash<bool>()(paging),
            std::hash<float>()(autoScroll),
            std::hash<bool>()(infiniteLoop),
            std::hash<bool>()(pageControl),
            std::hash<FlexLength>()(pageControlMarginLeft),
            std::hash<FlexLength>()(pageControlMarginRight),
            std::hash<FlexLength>()(pageControlMarginTop),
            std::hash<FlexLength>()(pageControlMarginBottom),
            std::hash<float>()(pageControlScale),
            [pageControlColor hash],
            [pageControlSelectedColor hash],
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
    
}
