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
            [attributedString hash],
//            [truncationAttributedString hash],
            std::hash<NSInteger>()(lineBreakMode),
            std::hash<NSInteger>()(lines),
            std::hash<float>()(kern),
            std::hash<float>()(lineSpacing),
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }

}
