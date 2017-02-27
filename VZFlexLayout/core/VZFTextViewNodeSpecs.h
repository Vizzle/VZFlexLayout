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

namespace VZ {
    struct TextViewNodeSpecs {
        NSString *text;
        UIColor *color;
        UIFont *font;
        NSTextAlignment alignment;
        NSString *placeholder;
        UIColor *placeholderColor;
        Value<BOOL, DefaultControlAttrValue::able> editable;
        BOOL secureTextEntry;
        UIKeyboardType keyboardType;
        UIKeyboardAppearance keyboardAppearance;
        UIReturnKeyType returnKeyType;
        Value<NSUInteger, DefaultAttributesValue::uintMax> maxLength;
        Value<BOOL, DefaultControlAttrValue::disable> blurOnSubmit;
        VZFEventBlock onFocus;
        VZFEventBlock onBlur;
        VZFEventBlock onChange;
        VZFEventBlock onSubmit;
        VZFEventBlock onEnd;
        VZFEventBlock onScroll;
        
        TextViewNodeSpecs copy() const {
            return {
                [text copy],
                color,
                font,
                alignment,
                [placeholder copy],
                placeholderColor,
                editable,
                secureTextEntry,
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
                [onScroll copy]
            };
        }

    };
}
