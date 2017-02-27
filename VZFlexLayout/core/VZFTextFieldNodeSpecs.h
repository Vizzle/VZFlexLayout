//
//  VZFTextFieldNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFEvent.h"
#import "VZFNodeSpecs.h"

namespace VZ {
    
    struct TextFieldNodeSpecs {
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
        UITextFieldViewMode clearButtonMode;
        Value<NSUInteger, DefaultAttributesValue::uintMax> maxLength;
        Value<BOOL, DefaultControlAttrValue::able> blurOnSubmit;
        Value<BOOL, DefaultControlAttrValue::able> enablesReturnKeyAutomatically;
        VZFEventBlock onFocus;
        VZFEventBlock onBlur;
        VZFEventBlock onChange;
        VZFEventBlock onSubmit;
        VZFEventBlock onEnd;
        
        TextFieldNodeSpecs copy() const {
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
                clearButtonMode,
                maxLength,
                blurOnSubmit,
                enablesReturnKeyAutomatically,
                [onFocus copy],
                [onBlur copy],
                [onChange copy],
                [onSubmit copy],
                [onEnd copy]
            };
        }
    };
}
