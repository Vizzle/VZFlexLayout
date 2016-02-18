//
//  VZFButtonNodeSpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"

namespace VZ {
    
    struct ButtonNodeSpecs{
        
        bool seleced;
        bool enabled;
        NSString* title;
        NSString* titleHighlight;
        UIFont* titleFont;
        UIColor* titleColor;
        UIColor* titleColorHighlight;
        UIImage* image;
        UIImage* backgroundImage;
        void(^action)(UIButton* btn);
        
        
        const ButtonNodeSpecs copy() const{
            return {
                seleced,
                enabled,
                [title copy],
                [titleFont copy],
                [titleColor copy],
                [image copy],
                [backgroundImage copy],
                [action copy],
            };
        }
        
        bool operator == (const ButtonNodeSpecs& other) const{
        
            return
            seleced == other.seleced &&
            enabled == other.enabled &&
            [title isEqualToString:other.title] &&
            Hash::_ObjectsEqual(titleColor, other.titleColor)&&
            Hash::_ObjectsEqual(titleColorHighlight, other.titleColorHighlight)&&
            Hash::_ObjectsEqual(titleFont, other.titleFont) &&
            Hash::_ObjectsEqual(image, other.image) &&
            Hash::_ObjectsEqual(backgroundImage, other.backgroundImage) &&
            action == other.action;
            
        }
    
    };
}