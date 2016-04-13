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
        
        NSString *text;
        UIColor *color;
        UIFont *font;
        NSTextAlignment textAlignment;
        NSAttributedString *attributedString;
//        NSAttributedString *truncationAttributedString;
//        NSCharacterSet *avoidTailTruncationSet;
        NSLineBreakMode lineBreakMode;
        NSUInteger maximumNumberOfLines;
//        CGSize shadowOffset;
//        UIColor *shadowColor;
//        CGFloat shadowOpacity;
//        CGFloat shadowRadius;
//        NSLayoutManager *(*layoutManagerFactory)(void);
        
        
        TextNodeSpecs copy() const
        {
            return {
                [text copy],
                [color copy],
                [font copy],
                textAlignment,
                [attributedString copy],
//                [truncationAttributedString copy],
//                [avoidTailTruncationSet copy],
                lineBreakMode,
                maximumNumberOfLines,
//                shadowOffset,
//                [shadowColor copy],
//                shadowOpacity,
//                shadowRadius,
//                layoutManagerFactory
            };
        };
        
        bool operator==(const TextNodeSpecs &other) const
        {
            // These comparisons are in a specific order to reduce the overall cost of this function.
            return lineBreakMode == other.lineBreakMode
            && Hash::_ObjectsEqual(text, other.text)
            && Hash::_ObjectsEqual(color, other.color)
            && Hash::_ObjectsEqual(font, other.font)
            && textAlignment == other.textAlignment
            && maximumNumberOfLines == other.maximumNumberOfLines
//            && shadowOpacity == other.shadowOpacity
//            && shadowRadius == other.shadowRadius
//            && layoutManagerFactory == other.layoutManagerFactory
//            && CGSizeEqualToSize(shadowOffset, other.shadowOffset)
//            && Hash::_ObjectsEqual(avoidTailTruncationSet, other.avoidTailTruncationSet)
//            && Hash::_ObjectsEqual(shadowColor, other.shadowColor)
            && Hash::_ObjectsEqual(attributedString, other.attributedString)
//            && Hash::_ObjectsEqual(truncationAttributedString, other.truncationAttributedString)
            ;
        }
        
        size_t hash() const;
        
        NSDictionary* getAttributes() const {
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = textAlignment;
            if (maximumNumberOfLines == 1) style.lineBreakMode = lineBreakMode;
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[NSParagraphStyleAttributeName] = style;
            dict[NSForegroundColorAttributeName] = color;
            dict[NSFontAttributeName] = font ?: [UIFont systemFontOfSize:17];
            return dict;
        }
        
        NSAttributedString* getAttributedString() const {
            if (attributedString) {
                NSMutableAttributedString *str = attributedString.mutableCopy;
                [attributedString enumerateAttributesInRange:NSMakeRange(0,attributedString.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    if (![attrs objectForKey:NSFontAttributeName]) {
                        if (font) dict[NSFontAttributeName] = font;
                    }
                    if (![attrs objectForKey:NSForegroundColorAttributeName]) {
                        dict[NSForegroundColorAttributeName] = color;
                    }
                    if (![attrs objectForKey:NSParagraphStyleAttributeName]) {
                        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                        style.alignment = textAlignment;
                        if (maximumNumberOfLines == 1) style.lineBreakMode = lineBreakMode;
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        dict[NSParagraphStyleAttributeName] = style;
                    }
                    if (dict.count) {
                        [str addAttributes:dict range:range];
                    }
                }];
                return str;
            }
            else if (text) {
                return [[NSAttributedString alloc] initWithString:text attributes:getAttributes()];
            }
            else {
                return nil;
            }
        }

    };
}

