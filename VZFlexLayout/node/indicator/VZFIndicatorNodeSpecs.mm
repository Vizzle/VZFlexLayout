//
//  VZFImageNodeSpec.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFIndicatorNodeSpecs.h"
#import "VZFUtils.h"

namespace VZ {
    
    size_t IndicatorNodeSpecs::hash() const {
        NSUInteger subhashes[] = {
            [color hash],
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
}
