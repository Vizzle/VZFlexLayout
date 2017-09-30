//
//  VZFScrollNodeSpecs.m
//  O2OReact
//
//  Created by moxin on 16/5/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFScrollNodeSpecs.h"
#import "VZFUtils.h"

namespace VZ {
    
    namespace DefaultFlexAttributesValue{
        ScrollDirection scrollDirection = ScrollHorizontal;
        bool scrollEnabled = true;
        bool scrollsToTop = false;
    }
    
    size_t ScrollNodeSpecs::hash() const{
        NSUInteger subhashes[] = {
            std::hash<bool>()(scrollDirection),
            std::hash<bool>()(scrollEnabled),
            std::hash<bool>()(scrollsToTop),
            std::hash<bool>()(paging)
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
    
    
    
}

