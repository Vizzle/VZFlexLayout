//
//  Font.m
//  FNode
//
//  Created by Sleen on 15/12/15.
//  Copyright © 2015年 O2O. All rights reserved.
//

#import "Font.h"

#if FLEX_IOS
#   define FNFontSymbolicTrait  UIFontSymbolicTrait
#   define FN_FONT_TRAIT(trait) UIFontDescriptorTrait##trait
#elif FLEX_OSX
#   define FNFontSymbolicTrait  NSFontSymbolicTrait
#   define FN_FONT_TRAIT(trait) NSFont##trait##Trait
#endif

namespace flex {
    
    const Float Font::defaultSize = 17;
    
    FontWrapper::FontWrapper(OSFont *font) {
        this->font.name = font.familyName.UTF8String;
        this->font.size = font.pointSize;
        uint32_t traits = [font.fontDescriptor.fontAttributes[FNFontSymbolicTrait] intValue];
        this->font.italic = traits & FN_FONT_TRAIT(Italic);
        this->font.bold = traits & FN_FONT_TRAIT(Bold);
        this->font.expanded = traits & FN_FONT_TRAIT(Expanded);
        this->font.condensed = traits & FN_FONT_TRAIT(Condensed);
        this->font.monoSpace = traits & FN_FONT_TRAIT(MonoSpace);
        this->font.vertical = traits & FN_FONT_TRAIT(Vertical);
        this->font.uiOptimized = traits & FN_FONT_TRAIT(UIOptimized);
    }
    
    FontWrapper::operator OSFont *() const {
        OSFont *ret = font.name.empty() ? [OSFont systemFontOfSize:font.size] : [OSFont fontWithName:[NSString stringWithUTF8String:font.name.c_str()] size:font.size];
        uint32_t traits = 0;
        if (font.italic) traits |= FN_FONT_TRAIT(Italic);
        if (font.bold) traits |= FN_FONT_TRAIT(Bold);
        if (font.expanded) traits |= FN_FONT_TRAIT(Expanded);
        if (font.condensed) traits |= FN_FONT_TRAIT(Condensed);
        if (font.monoSpace) traits |= FN_FONT_TRAIT(MonoSpace);
        if (font.vertical) traits |= FN_FONT_TRAIT(Vertical);
        if (font.uiOptimized) traits |= FN_FONT_TRAIT(UIOptimized);
        return [OSFont fontWithDescriptor:[ret.fontDescriptor fontDescriptorWithSymbolicTraits:traits] size:font.size];
    }
    
}
