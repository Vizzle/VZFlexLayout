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
    VZFFontStyleUltraLight,
    VZFFontStyleThin,
    VZFFontStyleLight,
    VZFFontStyleMedium,
    VZFFontStyleBold,
    VZFFontStyleHeavy,
    VZFFontStyleBlack,
    
    VZFFontStyleItalic,
    VZFFontStyleBoldItalic
};

typedef NS_ENUM(NSUInteger, VZFTextLineBreakMode) {
    VZFTextLineBreakByWord,
    VZFTextLineBreakByChar,
};

typedef NS_ENUM(NSUInteger, VZFTextTruncationMode) {
    VZFTextTruncatingTail,
    VZFTextTruncatingMiddle,
    VZFTextTruncatingHead,
    VZFTextTruncatingClip,
    VZFTextTruncatingNone,
};

typedef NS_ENUM(NSUInteger, VZFTextVerticalAlignment) {
    VZFTextVerticalAlignmentCenter,
    VZFTextVerticalAlignmentTop,
    VZFTextVerticalAlignmentBottom,
};

namespace VZ {
    
    UIFont *createFont(NSString *fontName, CGFloat fontSize, VZFFontStyle fontStyle);

    namespace DefaultFlexAttributesValue{
        extern unsigned int lines;
    }
    
    struct TextNodeSpecs{
        
        NSString *text;
        UIColor *color;
        float fontSize;
        NSString *fontName;
        VZFFontStyle fontStyle;
        float miniScaleFactor;
        BOOL adjustsFontSize;
        UIBaselineAdjustment baselineAdjustment;
        NSTextAlignment alignment;
        VZFTextVerticalAlignment verticalAlignment;
        VZFTextLineBreakMode lineBreakMode;
        VZFTextTruncationMode truncationMode;
        NSAttributedString *attributedString;
        Value<unsigned int, DefaultFlexAttributesValue::lines> lines;
        float kern;
        float lineSpacing;
//           NSAttributedString *truncationAttributedString;
        
        mutable UIFont *_font;
        
        TextNodeSpecs copy() const
        {
            return {
                [text copy],
                color,
                fontSize,
                [fontName copy],
                fontStyle,
                miniScaleFactor,
                adjustsFontSize,
                baselineAdjustment,
                alignment,
                verticalAlignment,
                lineBreakMode,
                truncationMode,
                [attributedString copy],
                lines,
                kern,
                lineSpacing,
                _font,    // _font
//                                [truncationAttributedString copy],
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
            && kern == other.kern
            && lineSpacing == other.lineSpacing
            && Hash::_ObjectsEqual(attributedString, other.attributedString);
//            && Hash::_ObjectsEqual(truncationAttributedString, other.truncationAttributedString);
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
            if (lineSpacing != 0) {
                style.lineSpacing = lineSpacing;
            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict[NSParagraphStyleAttributeName] = style;
            dict[NSForegroundColorAttributeName] = color;
            if (kern != 0) {
                dict[NSKernAttributeName] = @(kern);
                dict[NSLigatureAttributeName] = @0;
            }
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
                        style.lineSpacing = lineSpacing;
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

