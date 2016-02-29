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

namespace VZ {
    
    template<>
    struct MultiMapKey<UIControlEvents> {
        static UIControlEvents defaultKey;
    };
    
    struct ButtonNodeSpecs{
        UIFont *font;
        NSTextAlignment textAlignment;
        StatefulValue<NSString *>title;     // IMPORTANT: node won't re-layout when the title is changed by state-changing.
        StatefulValue<UIColor *> titleColor;
        StatefulValue<UIImage *> backgroundImage;
        StatefulValue<UIImage *> image;
        MultiMap<UIControlEvents, ActionWrapper> action;
        // the image property was not supported, use an image node nested in a button node instead.
        
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
        
            return VZ::Hash::_ObjectsEqual(font, other.font)
                && title == other.title
                && titleColor == other.titleColor
                && backgroundImage == other.backgroundImage
                && action == other.action
                && image == other.backgroundImage;
            
        }
    
    };
}

typedef VZ::ButtonNodeSpecs VZButtonSpecs;
