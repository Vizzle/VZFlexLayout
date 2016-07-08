//
//  VZSizeRange.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/14.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFSizeRange.h"
#import "VZFNodeSpecs.h"
#import "VZFValue.h"


namespace VZ {
    CGSize containerSize(VZFSizeRange type, CGSize givenSize){
        
        if (type == VZFlexibleSizeWidthAndHeight) {
            return (CGSize){FlexValue::Auto,FlexValue::Auto};
        }
        else if (type == VZFlexibleSizeHeight){
            return (CGSize){givenSize.width,FlexValue::Auto};
        }
        else if (type == VZFlexibleSizeWidth){
            return (CGSize){FlexValue::Auto,givenSize.height};
        }
        else if (type == VZFlexibleSizeNone){
            return givenSize;
        }
        else{
            return givenSize;
        }
    }
}
using namespace VZ;
@implementation VZSizeRangeProvider
{
    VZFSizeRange _range;
}
- (CGSize)rangeSizeForBounds:(CGSize)size{

    if (_range == VZFlexibleSizeWidthAndHeight) {
        return (CGSize){FlexValue::Auto,FlexValue::Auto};
    }
    else if (_range == VZFlexibleSizeHeight){
        return (CGSize){size.width,FlexValue::Auto};
    }
    else if (_range == VZFlexibleSizeWidth){
        return (CGSize){FlexValue::Auto,size.height};
    }
    else if (_range == VZFlexibleSizeNone){
        return size;
    }
    else{
        return size;
    }
}

+ (instancetype)rangeProvider:(VZFSizeRange)range{

    VZSizeRangeProvider* provider = [VZSizeRangeProvider new];
    provider -> _range = range;
    return provider;
}

@end


