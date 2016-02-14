//
//  VZFSizeRange.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/14.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VZFValue){
    
    VZFlexUndefined = -999999,  // used in properties: marginTop, paddingTop, ...
    VZFlexInfinite = -999998, // used in constraintedSize, maxWidth, maxHeight
    VZFlexAuto = -999997,    // used in properties: flexBasis, width, height, margin, padding, marginTop, ...
    VZFlexContent = -999996        // used in properties: flexBasis
};

typedef NS_ENUM(NSUInteger,VZFSizeRange) {

    VZFlexibleSizeWidthAndHeight,
    VZFlexibleSizeWidth,
    VZFlexibleSizeHeight,
    VZFlexibleSizeNone
};

@protocol VZSizeRangeProvider <NSObject>

@optional
- (CGSize)rangeSize:(VZFSizeRange)range ForBounds:(CGSize)size;

@end

@interface VZSizeRangeProvider : NSObject<VZSizeRangeProvider>

@end