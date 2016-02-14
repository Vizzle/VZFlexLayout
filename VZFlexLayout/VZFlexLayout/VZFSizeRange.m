//
//  VZSizeRange.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/14.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFSizeRange.h"


@implementation VZSizeRangeProvider

- (CGSize)rangeSize:(VZSizeRange)range ForBounds:(CGSize)size{

    if (range == VZFlexibleSizeWidthAndHeight) {
        return (CGSize){0,0};
    }
    else if (range == VZFlexibleSizeHeight){
        return (CGSize){size.width,0};
    }
    else if (range == VZFlexibleSizeWidth){
        return (CGSize){0,size.height};
    }
    else if (range == VZFlexibleSizeNone){
        return size;
    }
    else{
        return size;
    }
}

@end


