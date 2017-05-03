//
//  VZFTextFieldNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"

namespace VZ {
    namespace DefaultTextFieldAttrValue {
        extern NSUInteger defaultMaxLength;
    }
    struct TextFieldNodeSpecs {
        NSString *text;
        UIColor *color;
        float fontSize;
        NSString *fontName;
        VZFFontStyle fontStyle;
        NSTextAlignment alignment;
        NSString *placeholder;
        UIColor *placeholderColor;
        Value<BOOL, DefaultControlAttrValue::able> editable;
        BOOL secureTextEntry;
        UIKeyboardType keyboardType;
        UIKeyboardAppearance keyboardAppearance;
        UIReturnKeyType returnKeyType;
        UITextFieldViewMode clearButtonMode;
        Value<NSUInteger, DefaultTextFieldAttrValue::defaultMaxLength> maxLength;
        Value<BOOL, DefaultControlAttrValue::able> blurOnSubmit;
        Value<BOOL, DefaultControlAttrValue::disable> autoFocus;
        VZFEventBlock onFocus;
        VZFEventBlock onBlur;
        VZFEventBlock onChange;
        VZFEventBlock onSubmit;
        VZFEventBlock onEnd;
        
        mutable UIFont *_font;
        
        UIFont *getFont() const {
            if (!_font) {
                _font = createFont(fontName, fontSize, fontStyle);
            }
            return _font;
        }
        
        TextFieldNodeSpecs copy() const {
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
                secureTextEntry,
                keyboardType,
                keyboardAppearance,
                returnKeyType,
                clearButtonMode,
                maxLength,
                blurOnSubmit,
                autoFocus,
                [onFocus copy],
                [onBlur copy],
                [onChange copy],
                [onSubmit copy],
                [onEnd copy],
                _font,
            };
        }
    };
}
