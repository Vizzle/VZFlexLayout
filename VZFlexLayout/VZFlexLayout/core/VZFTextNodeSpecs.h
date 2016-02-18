//
//  VZFTextNodeSpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"

namespace VZ {


    struct TextNodeSpecs{
        
        
        NSAttributedString *attributedString;
        NSAttributedString *truncationAttributedString;
        NSCharacterSet *avoidTailTruncationSet;
        NSLineBreakMode lineBreakMode;
        NSUInteger maximumNumberOfLines;
        CGSize shadowOffset;
        UIColor *shadowColor;
        CGFloat shadowOpacity;
        CGFloat shadowRadius;
        NSLayoutManager *(*layoutManagerFactory)(void);
        
        
        
        const TextNodeSpecs copy() const
        {
            return {
                [attributedString copy],
                [truncationAttributedString copy],
                [avoidTailTruncationSet copy],
                lineBreakMode,
                maximumNumberOfLines,
                shadowOffset,
                [shadowColor copy],
                shadowOpacity,
                shadowRadius,
                layoutManagerFactory
            };
        };
        
        bool operator==(const TextNodeSpecs &other) const
        {
            // These comparisons are in a specific order to reduce the overall cost of this function.
            return lineBreakMode == other.lineBreakMode
            && maximumNumberOfLines == other.maximumNumberOfLines
            && shadowOpacity == other.shadowOpacity
            && shadowRadius == other.shadowRadius
            && layoutManagerFactory == other.layoutManagerFactory
            && CGSizeEqualToSize(shadowOffset, other.shadowOffset)
            && Hash::_ObjectsEqual(avoidTailTruncationSet, other.avoidTailTruncationSet)
            && Hash::_ObjectsEqual(shadowColor, other.shadowColor)
            && Hash::_ObjectsEqual(attributedString, other.attributedString)
            && Hash::_ObjectsEqual(truncationAttributedString, other.truncationAttributedString);
        }
        
        size_t hash() const;
        
    };
}