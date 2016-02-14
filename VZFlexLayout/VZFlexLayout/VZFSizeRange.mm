//
//  VZSizeRange.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/14.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFSizeRange.h"
#import "VZFValue.h"

@implementation VZSizeRangeProvider

- (CGSize)rangeSize:(VZFSizeRange)range ForBounds:(CGSize)size{

    if (range == VZFlexibleSizeWidthAndHeight) {
        return (CGSize){VZFlexInfinite,VZFlexInfinite};
    }
    else if (range == VZFlexibleSizeHeight){
        return (CGSize){size.width,VZFlexInfinite};
    }
    else if (range == VZFlexibleSizeWidth){
        return (CGSize){VZFlexInfinite,size.height};
    }
    else if (range == VZFlexibleSizeNone){
        return size;
    }
    else{
        return size;
    }
}

@end


