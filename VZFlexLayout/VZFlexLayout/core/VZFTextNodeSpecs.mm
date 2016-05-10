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
        NSUInteger lines = 1;
        NSLineBreakMode lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    UIFont *createFont(NSString *fontName, CGFloat fontSize, VZFFontStyle fontStyle) {
        if (fontSize == 0) fontSize = [UIFont systemFontSize];
        UIFontDescriptorSymbolicTraits traits = UIFontDescriptorSymbolicTraits();
        switch (fontStyle) {
            case VZFFontStyleNormal:
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
        return [UIFont fontWithDescriptor:fontDescriptor size:fontSize];
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
//            [avoidTailTruncationSet hash],
//            std::hash<NSUInteger>()((NSUInteger) layoutManagerFactory),
            std::hash<NSInteger>()(lineBreakMode),
            std::hash<NSInteger>()(lines),
//            std::hash<CGFloat>()(shadowOffset.width),
//            std::hash<CGFloat>()(shadowOffset.height),
//            [shadowColor hash],
//            std::hash<CGFloat>()(shadowOpacity),
//            std::hash<CGFloat>()(shadowRadius),
        };
        return VZ::Hash::IntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
    }

}