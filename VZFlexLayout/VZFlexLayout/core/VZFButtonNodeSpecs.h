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

namespace VZ {
    
    typedef void(^UIControlActionBlock)(id sender);
    
    template<typename Type>
    struct EventfulValue : std::unordered_multimap<UIControlEvents, Type> {
        using SuperType = std::unordered_multimap<UIControlEvents, Type>;
        
        EventfulValue() : SuperType() {}
        EventfulValue(Type value) : SuperType({{UIControlEventTouchUpInside, value}}) {}
        EventfulValue(std::initializer_list<typename SuperType::value_type> list) : SuperType(list) {}
    };
    
    struct ButtonNodeSpecs{

        UIFont *font;
        NSTextAlignment textAlignment;
        StatefulValue<NSString *>title;     // IMPORTANT: node won't re-layout when the title is changed by state-changing.
        StatefulValue<UIColor *> titleColor;
        StatefulValue<UIImage *> backgroundImage;
        EventfulValue<UIControlActionBlock> actionBlock;
        EventfulValue<SEL> actionSelector;
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
                && actionBlock == other.actionBlock;
            
        }
    
    };
}