//
//  VZFButtonNodeSpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFValue.h"
#import "VZFActionWrapper.h"
#import "VZFTextNodeSpecs.h"

namespace VZ {
    
    namespace  DefaultButtonAttributesValue{
        extern CGSize enlargeSize;
    };
    
    struct ButtonNodeSpecs{
        CGFloat fontSize;
        NSString *fontName;
        VZFFontStyle fontStyle;
        StatefulValue<NSString *>title;     // IMPORTANT: node won't re-layout when the title is changed by state-changing.
        StatefulValue<UIColor *> titleColor;
        StatefulValue<UIImage *> backgroundImage;
        StatefulValue<UIImage *> image;
        
        //enlarge touch area
        Value<CGSize, DefaultButtonAttributesValue::enlargeSize> enlargeSize;
        mutable UIFont *_font;
        
        VZFBlockAction* action;
        // the image property was not supported, use an image node nested in a button node instead.
        
        UIFont *getFont() const {
            if (!_font) {
                _font = createFont(fontName, fontSize, fontStyle);
            }
            return _font;
        }
        
        const ButtonNodeSpecs copy() const{
            return *this;
//            return {
//
//                [title copy],
//                [titleHighlight copy],
//                [titleFont copy],
//                [titleColor copy],
//                [titleColorHighlight copy],
//                [image copy],
//                [imageHighlight copy],
//                [backgroundImage copy],
//                [backgroundImageHighlight copy],
//                [action copy],
//            };
        }
        
        bool operator == (const ButtonNodeSpecs& other) const{
        
            return Hash::_ObjectsEqual(fontName, other.fontName)
                && fontSize == other.fontSize
                && fontStyle == other.fontStyle
                && title == other.title
                && titleColor == other.titleColor
                && backgroundImage == other.backgroundImage
                && action == other.action
                && image == other.backgroundImage;
            
        }
    
    };
}

