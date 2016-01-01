//
//  Length.m
//  FNode
//
//  Created by Sleen on 15/12/24.
//  Copyright © 2015年 O2O. All rights reserved.
//

#import "Length.h"

namespace flex {
    
    Float Length::absoluteValue() const {
        switch(type) {
            case LengthType::Point:
                return value;
            case LengthType::Pixel:
                return value / SCREEN_SCALE;
            default:
                return 0;
        }
    }
    
}
