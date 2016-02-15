//
//  VZFSizeRange.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/14.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,VZFSizeRange) {

    VZFlexibleSizeWidthAndHeight,
    VZFlexibleSizeWidth,
    VZFlexibleSizeHeight,
    VZFlexibleSizeNone
};

@protocol VZSizeRangeProvider <NSObject>

@optional
- (CGSize)rangeSizeForBounds:(CGSize)size;

@end

@interface VZSizeRangeProvider : NSObject<VZSizeRangeProvider>

+ (instancetype)defaultRangeProvider:(VZFSizeRange)range;

@end