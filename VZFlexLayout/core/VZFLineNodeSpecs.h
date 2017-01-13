//
//  VZFLineNodeSpecs.h
//  O2OReact
//
//  Created by Sleen on 16/8/5.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace VZ {
    
    struct LineNodeSpecs {
        UIColor *color;
        CGFloat dashLength;
        CGFloat spaceLength;
        
        const LineNodeSpecs copy() const{
            return { color, dashLength, spaceLength };
        }
        
        bool operator == (const LineNodeSpecs &other) const {
            return (color == other.color
                    && dashLength == other.dashLength
                    && spaceLength == other.spaceLength);
        }
        
        size_t hash() const;
        
    };

}