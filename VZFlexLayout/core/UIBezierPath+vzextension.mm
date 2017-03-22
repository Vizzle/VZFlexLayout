//
//  UIBezierPath+extension.m
//  VZFlexLayout
//
//  Created by pep on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "UIBezierPath+vzextension.h"
#import <algorithm>

@implementation UIBezierPath (extension)

+ (UIBezierPath *)vz_roundRectPathWithWidth:(CGFloat)width
                                   height:(CGFloat)height
                            topLeftRadius:(CGFloat)topLeftRadius
                           topRightRadius:(CGFloat)topRightRadius
                         bottomLeftRadius:(CGFloat)bottomLeftRadius
                        bottomRightRadius:(CGFloat)bottomRightRadius
{
    CGFloat top_left_x = topLeftRadius;
    CGFloat top_left_y = topLeftRadius;
    CGFloat top_right_x = topRightRadius;
    CGFloat top_right_y = topRightRadius;
    CGFloat bottom_left_x = bottomLeftRadius;
    CGFloat bottom_left_y = bottomLeftRadius;
    CGFloat bottom_right_x = bottomRightRadius;
    CGFloat bottom_right_y = bottomRightRadius;
    if (top_left_x + top_right_x > width) {
        CGFloat factor = width / (top_left_x + top_right_x);
        top_left_x *= factor;
        top_right_x *= factor;
    }
    if (bottom_left_x + bottom_right_x > width) {
        CGFloat factor = width / (bottom_left_x + bottom_right_x);
        bottom_left_x *= factor;
        bottom_right_x *= factor;
    }
    if (top_left_y + bottom_left_y > height) {
        CGFloat factor = height / (top_left_y + bottom_left_y);
        top_left_y *= factor;
        bottom_left_y *= factor;
    }
    if (top_right_y + bottom_right_y > height) {
        CGFloat factor = height / (top_right_y + bottom_right_y);
        top_right_y *= factor;
        bottom_right_y *= factor;
    }
    CGFloat top_left = std::min(top_left_x, top_left_y);
    CGFloat top_right = std::min(top_right_x, top_right_y);
    CGFloat bottom_left = std::min(bottom_left_x, bottom_left_y);
    CGFloat bottom_right = std::min(bottom_right_x, bottom_right_y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(top_left, 0)];
    [path addLineToPoint:CGPointMake(width - top_right, 0)];
    if (top_right > 0) {
        [path addArcWithCenter:CGPointMake(width - top_right, top_right) radius:top_right startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(width, height - bottom_right)];
    if (bottom_right > 0) {
        [path addArcWithCenter:CGPointMake(width - bottom_right, height - bottom_right) radius:bottom_right startAngle:0 endAngle:M_PI_2 clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(bottom_left, height)];
    if (bottom_left > 0) {
        [path addArcWithCenter:CGPointMake(bottom_left, height - bottom_left) radius:bottom_left startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    [path addLineToPoint:CGPointMake(0, top_left)];
    if (top_left > 0) {
        [path addArcWithCenter:CGPointMake(top_left, top_left) radius:top_left startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    }
    [path closePath];
    
    return path;
}

@end
