//
//  VZFTextFieldNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFTextFieldEventHandler.h"

namespace VZ {
    struct TextFieldNodeSpecs {
        NSString *text;
        UIColor *color;
        UIFont *font;
        NSTextAlignment alignment;
        NSString *placeholder;
        UITextFieldViewMode clearButtonMode;
        VZFTextFieldEventHandler *eventHandler;
        
        TextFieldNodeSpecs copy() const {
            return {
                [text copy],
                color,
                font,
                alignment,
                [placeholder copy],
                clearButtonMode,
                eventHandler
            };
        }
    };
}
