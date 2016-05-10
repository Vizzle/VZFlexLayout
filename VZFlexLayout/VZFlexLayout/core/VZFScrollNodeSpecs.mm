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
    
    size_t ScrollNodeSpecs::hash() const{
        NSUInteger subhashes[] = {
            std::hash<bool>()(scrollEnabled),
            std::hash<int>()(direction),
            std::hash<float>()(spacing),
            std::hash<bool>()(paging),
            std::hash<bool>()(autoScroll),
            std::hash<float>()(autoScrollerTimeInterval),
            std::hash<bool>()(infiniteLoop)
            
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
    
    
    
}

