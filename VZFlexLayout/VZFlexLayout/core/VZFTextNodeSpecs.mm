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
        NSLineBreakMode lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    UIFont *createFont(NSString *fontName, CGFloat fontSize, VZFFontStyle fontStyle) {
        if (fontSize == 0) fontSize = [UIFont systemFontSize];
        UIFont *font = nil;
        // 加快字体创建
        if (fontName.length == 0 && fontStyle != VZFFontStyleBoldItalic) {
            switch (fontStyle) {
                case VZFFontStyleBold:
                    font = [UIFont boldSystemFontOfSize:fontSize];
                    break;
                case VZFFontStyleItalic:
                    font = [UIFont italicSystemFontOfSize:fontSize];
                    break;
                case VZFFontStyleThin:
                    // iOS8+才能支持细体
                    if ([UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
                        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
                    } else {
                        font = [UIFont systemFontOfSize:fontSize];
                    }
                    break;
                default:
                    font = [UIFont systemFontOfSize:fontSize];
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
                case VZFFontStyleThin:
                    break;
                case VZFFontStyleBold:
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
            fontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:traits];
            font = [UIFont fontWithDescriptor:fontDescriptor size:fontSize];
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
            std::hash<CGFloat>()(kern),
            std::hash<CGFloat>()(lineSpacing),
//            std::hash<CGFloat>()(shadowOffset.width),
//            std::hash<CGFloat>()(shadowOffset.height),
//            [shadowColor hash],
//            std::hash<CGFloat>()(shadowOpacity),
//            std::hash<CGFloat>()(shadowRadius)
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }

}
