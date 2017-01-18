//
//  VZFImageNodeRenderer.h
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VZFImageNodeRenderer : NSObject

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) NSInteger animateCount;

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds;

@end
