//
//  VZFImageNodeSpec.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFImageNodeSpecs.h"
#import "VZFUtils.h"

namespace VZ {
    
    size_t ImageNodeSpecs::hash() const{
        NSUInteger subhashes[] = {
            [image hash],
            std::hash<NSInteger>()(contentMode),
            [imageUrl hash],
            [errorImage hash]
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
}
