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
        Value<BOOL, DefaultControlAttrValue::able> editable;
        BOOL secureTextEntry;
        UIKeyboardType keyboardType;
        UIKeyboardAppearance keyboardAppearance;
        UIReturnKeyType returnKeyType;
        Value<NSUInteger, DefaultAttributesValue::uintMax> maxLength;
        VZFEventBlock onFocus;
        VZFEventBlock onBlur;
        VZFEventBlock onChange;
        VZFEventBlock onSubmit;
        VZFEventBlock onKeyPress;
        VZFEventBlock onEnd;
        VZFEventBlock onScroll;
        
        TextViewNodeSpecs copy() const {
            return {
                [text copy],
                color,
                font,
                alignment,
                [placeholder copy],
                editable,
                secureTextEntry,
                keyboardType,
                keyboardAppearance,
                returnKeyType,
                maxLength,
                [onFocus copy],
                [onBlur copy],
                [onChange copy],
                [onSubmit copy],
                [onKeyPress copy],
                [onEnd copy],
                [onScroll copy]
            };
        }

    };
}
