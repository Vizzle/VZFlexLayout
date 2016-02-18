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

        NSString* title;
        NSString* titleHighlight;
        UIFont* titleFont;
        UIColor* titleColor;
        UIColor* titleColorHighlight;
        UIImage* image;
        UIImage* imageHighlight;
        UIImage* backgroundImage;
        UIImage* backgroundImageHighlight;
        void(^action)(UIButton* btn);
        
        
        const ButtonNodeSpecs copy() const{
            return {

                [title copy],
                [titleHighlight copy],
                [titleFont copy],
                [titleColor copy],
                [titleColorHighlight copy],
                [image copy],
                [imageHighlight copy],
                [backgroundImage copy],
                [backgroundImageHighlight copy],
                [action copy],
            };
        }
        
        bool operator == (const ButtonNodeSpecs& other) const{
        
            return

            [title isEqualToString:other.title] &&
            [titleHighlight isEqualToString:other.titleHighlight] &&
            Hash::_ObjectsEqual(titleColor, other.titleColor)&&
            Hash::_ObjectsEqual(titleColorHighlight, other.titleColorHighlight)&&
            Hash::_ObjectsEqual(titleFont, other.titleFont) &&
            Hash::_ObjectsEqual(image, other.image) &&
            Hash::_ObjectsEqual(imageHighlight, other.imageHighlight) &&
            Hash::_ObjectsEqual(backgroundImage, other.backgroundImage) &&
            Hash::_ObjectsEqual(backgroundImageHighlight, other.backgroundImageHighlight) &&
            action == other.action;
            
        }
    
    };
}