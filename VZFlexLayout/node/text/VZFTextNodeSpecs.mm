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
    
    namespace DefaultFlexAttributesValue{
        unsigned int lines = 1;
    }
    
    UIFont *createFont(NSString *fontName, CGFloat fontSize, VZFFontStyle fontStyle) {
        if (fontSize == 0) fontSize = [UIFont systemFontSize];
        UIFont *font = nil;
        // 加快字体创建
        if (fontName.length == 0 && fontStyle != VZFFontStyleBoldItalic) {
            if (fontStyle == VZFFontStyleItalic) {
                font = [UIFont italicSystemFontOfSize:fontSize];
            } else if (fontStyle == VZFFontStyleBold) {
                font = [UIFont boldSystemFontOfSize:fontSize];
            } else if (fontStyle == VZFFontStyleNormal) {
                font = [UIFont systemFontOfSize:fontSize];
            } else {
                if ([UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
                    CGFloat weight;
                    switch (fontStyle) {
                        case VZFFontStyleUltraLight:
                            weight = UIFontWeightUltraLight;
                            break;
                        case VZFFontStyleThin:
                            weight = UIFontWeightThin;
                            break;
                        case VZFFontStyleLight:
                            weight = UIFontWeightLight;
                            break;
                        case VZFFontStyleMedium:
                            weight = UIFontWeightMedium;
                            break;
                        case VZFFontStyleHeavy:
                            weight = UIFontWeightHeavy;
                            break;
                        case VZFFontStyleBlack:
                            weight = UIFontWeightBlack;
                            break;
                        default:
                            weight = UIFontWeightRegular;
                            break;
                    }
                    font = [UIFont systemFontOfSize:fontSize weight:weight];
                } else {
                    switch (fontStyle) {
                        case VZFFontStyleMedium:
                        case VZFFontStyleHeavy:
                        case VZFFontStyleBlack:
                            font = [UIFont boldSystemFontOfSize:fontSize];
                            break;
                        case VZFFontStyleUltraLight:
                        case VZFFontStyleThin:
                        case VZFFontStyleLight:
                        default:
                            font = [UIFont systemFontOfSize:fontSize];
                            break;
                    }
                }
            }
        }
        else if (fontStyle == VZFFontStyleNormal) {
            font = [UIFont fontWithName:fontName size:fontSize];
        }
        else {
            // 指定字体名称时暂时无法支持细体
            UIFontDescriptorSymbolicTraits traits = UIFontDescriptorSymbolicTraits();
            switch (fontStyle) {
                case VZFFontStyleNormal:
                case VZFFontStyleUltraLight:
                case VZFFontStyleThin:
                case VZFFontStyleLight:
                    break;
                case VZFFontStyleMedium:
                case VZFFontStyleBold:
                case VZFFontStyleHeavy:
                case VZFFontStyleBlack:
                    traits |= UIFontDescriptorTraitBold;
                    break;
                case VZFFontStyleItalic:
                    traits |= UIFontDescriptorTraitItalic;
                    break;
                case VZFFontStyleBoldItalic:
                    traits |= UIFontDescriptorTraitBold;
                    traits |= UIFontDescriptorTraitItalic;
                    break;
            }
            UIFontDescriptor *fontDescriptor;
            if (fontName.length > 0) {
                fontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:fontSize];
            } else {
                fontDescriptor = [[UIFontDescriptor alloc] init];
                fontDescriptor = [fontDescriptor fontDescriptorWithSize:fontSize];
            }
            fontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:traits] ?: fontDescriptor;
            if (fontDescriptor) {
                font = [UIFont fontWithDescriptor:fontDescriptor size:fontSize];
            }
        }
        if (!font) {
            font = [UIFont systemFontOfSize:fontSize];
        }
        return font;
    }
    
    UIFont* TextNodeSpecs::getFont() const{
        
        if (!_font) {
            _font = createFont(fontName, fontSize, fontStyle);
        }
        return _font;
    }
    
    NSDictionary* TextNodeSpecs::getAttributes()const{
    
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
    
    NSAttributedString* TextNodeSpecs::getAttributedString() const{
    
        if (_attributedString) {
            NSMutableAttributedString *str = _attributedString.mutableCopy;
            [_attributedString enumerateAttributesInRange:NSMakeRange(0,_attributedString.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
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
    
    TextNodeSpecs TextNodeSpecs::copy() const{
        
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
            [_attributedString copy],
            lines,
            kern,
            lineSpacing,
            _font,    // _font
            linkAction,
        };
    }
    
    size_t TextNodeSpecs::hash() const
    {
        NSUInteger subhashes[] = {
            [text hash],
            [color hash],
            [_font hash],
            [fontName hash],
            std::hash<NSInteger>()(fontStyle),
            std::hash<CGFloat>()(fontSize),
            std::hash<NSInteger>()(alignment),
            [_attributedString hash],
            std::hash<NSInteger>()(lineBreakMode),
            std::hash<NSInteger>()(lines),
            std::hash<float>()(kern),
            std::hash<float>()(lineSpacing),
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }
    
    
    bool TextNodeSpecs::operator==(const VZ::TextNodeSpecs &other) const{
    
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
        && Hash::_ObjectsEqual(_attributedString, other._attributedString);
    }

}
