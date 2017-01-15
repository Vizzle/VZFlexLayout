//
//  VZFLineNodeSpecs.m
//  O2OReact
//
//  Created by Sleen on 16/8/5.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFLineNodeSpecs.h"
#import "VZFUtils.h"

namespace VZ {

    size_t LineNodeSpecs::hash() const{
        NSUInteger subhashes[] = {
            std::hash<CGFloat>()(dashLength),
            std::hash<CGFloat>()(spaceLength),
            [color hash],
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
    
}
