//
//  VZFTextNodeSpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFValue.h"

typedef NS_ENUM(NSUInteger, VZFFontStyle) {
    VZFFontStyleNormal,
    VZFFontStyleBold,
    VZFFontStyleItalic,
    VZFFontStyleBoldItalic,
};

namespace VZ {
    
    UIFont *createFont(NSString *fontName, CGFloat fontSize, VZFFontStyle fontStyle);

    namespace DefaultFlexAttributesValue{
        extern NSUInteger lines;
        extern NSLineBreakMode lineBreakMode;
    }
    
    struct TextNodeSpecs{
        
        NSString *text;
        UIColor *color;
        CGFloat fontSize;
        NSString *fontName;
        VZFFontStyle fontStyle;
        NSTextAlignment alignment;
        NSAttributedString *attributedString;
//        NSAttributedString *truncationAttributedString;
//        NSCharacterSet *avoidTailTruncationSet;
        Value<NSLineBreakMode, DefaultFlexAttributesValue::lineBreakMode> lineBreakMode;
        Value<NSUInteger, DefaultFlexAttributesValue::lines> lines;
//        CGSize shadowOffset;
//        UIColor *shadowColor;
//        CGFloat shadowOpacity;
//        CGFloat shadowRadius;
//        NSLayoutManager *(*layoutManagerFactory)(void);
        
        mutable UIFont *_font;
        
        TextNodeSpecs copy() const
        {
            return {
                [text copy],
                color,
                fontSize,
                [fontName copy],
                fontStyle,
                alignment,
                [attributedString copy],
//                [truncationAttributedString copy],
//                [avoidTailTruncationSet copy],
                lineBreakMode,
                lines,
//                shadowOffset,
//                [shadowColor copy],
//                shadowOpacity,
//                shadowRadius,
//                layoutManagerFactory
                _font,    // _font
            };
        };
        
        bool operator==(const TextNodeSpecs &other) const
        {
            // These comparisons are in a specific order to reduce the overall cost of this function.
            return lineBreakMode == other.lineBreakMode
            && Hash::_ObjectsEqual(text, other.text)
            && Hash::_ObjectsEqual(color, other.color)
            && Hash::_ObjectsEqual(fontName, other.fontName)
            && fontSize == other.fontSize
            && fontStyle == other.fontStyle
            && alignment == other.alignment
            && lines == other.lines
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
        
        UIFont *getFont() const {
            if (!_font) {
                _font = createFont(fontName, fontSize, fontStyle);
            }
            return _font;
        }
        
        NSDictionary* getAttributes() const {
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = alignment;
            if (lines == 1) style.lineBreakMode = lineBreakMode;
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[NSParagraphStyleAttributeName] = style;
            dict[NSForegroundColorAttributeName] = color;
            
            dict[NSFontAttributeName] = getFont();
            return dict;
        }
        
        NSAttributedString* getAttributedString() const {
            if (attributedString) {
                NSMutableAttributedString *str = attributedString.mutableCopy;
                [attributedString enumerateAttributesInRange:NSMakeRange(0,attributedString.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    if (![attrs objectForKey:NSFontAttributeName]) {
                        if (getFont()) dict[NSFontAttributeName] = getFont();
                    }
                    if (![attrs objectForKey:NSForegroundColorAttributeName]) {
                        dict[NSForegroundColorAttributeName] = color;
                    }
                    if (![attrs objectForKey:NSParagraphStyleAttributeName]) {
                        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                        style.alignment = alignment;
                        if (lines == 1) style.lineBreakMode = lineBreakMode;
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

