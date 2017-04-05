//
//  VZFTextViewNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"

namespace VZ {
    namespace DefaultTextViewAttrValue {
        extern NSUInteger defaultMaxLength;
    }
    struct TextViewNodeSpecs {
        NSString *text;
        UIColor *color;
        float fontSize;
        NSString *fontName;
        VZFFontStyle fontStyle;
        NSTextAlignment alignment;
        NSString *placeholder;
        UIColor *placeholderColor;
        Value<BOOL, DefaultControlAttrValue::able> editable;
        Value<BOOL, DefaultControlAttrValue::disable> autoFocus;
        UIKeyboardType keyboardType;
        UIKeyboardAppearance keyboardAppearance;
        UIReturnKeyType returnKeyType;
        Value<NSUInteger, DefaultTextViewAttrValue::defaultMaxLength> maxLength;
        Value<BOOL, DefaultControlAttrValue::disable> blurOnSubmit;
        VZFEventBlock onFocus;
        VZFEventBlock onBlur;
        VZFEventBlock onChange;
        VZFEventBlock onSubmit;
        VZFEventBlock onEnd;
        VZFEventBlock onScroll;
        
        mutable UIFont *_font;
        
        UIFont *getFont() const {
            if (!_font) {
                _font = createFont(fontName, fontSize, fontStyle);
            }
            return _font;
        }
        
        TextViewNodeSpecs copy() const {
            return {
                [text copy],
                color,
                fontSize,
                [fontName copy],
                fontStyle,
                alignment,
                [placeholder copy],
                placeholderColor,
                editable,
                autoFocus,
                keyboardType,
                keyboardAppearance,
                returnKeyType,
                maxLength,
                blurOnSubmit,
                [onFocus copy],
                [onBlur copy],
                [onChange copy],
                [onSubmit copy],
                [onEnd copy],
                [onScroll copy],
                _font,
            };
        }

    };
}
