//
//  VZFTextNodeSpecs.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNodeSpecs.h"
#include <functional>

namespace VZ {
    
    size_t TextNodeSpecs::hash() const
    {
        NSUInteger subhashes[] = {
            [attributedString hash],
            [truncationAttributedString hash],
            [avoidTailTruncationSet hash],
            std::hash<NSUInteger>()((NSUInteger) layoutManagerFactory),
            std::hash<NSInteger>()(lineBreakMode),
            std::hash<NSInteger>()(maximumNumberOfLines),
            std::hash<CGFloat>()(shadowOffset.width),
            std::hash<CGFloat>()(shadowOffset.height),
            [shadowColor hash],
            std::hash<CGFloat>()(shadowOpacity),
            std::hash<CGFloat>()(shadowRadius),
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }

}