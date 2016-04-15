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

+ (instancetype)defaultRangeProvider:(VZFSizeRange)range{

    static VZSizeRangeProvider* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VZSizeRangeProvider new];
        instance -> _range = range;
    });
    return instance;
}

@end


