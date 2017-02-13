//
//  VZFBlankNodeRenderer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFBlankNodeRenderer.h"

@implementation VZFBlankNodeRenderer


- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds {
    
//    CGContextSaveGState(context);
//    
//    UIBezierPath *path = nil;
//    if (self.cornerRadius>0) {
//        path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:self.cornerRadius];
//    } else {
//        path = [UIBezierPath bezierPathWithRect:bounds];
//    };
//    
//    CGContextAddPath(context, path.CGPath);
//    CGContextClip(context);
//    
//    //背景色
//    if (self.backgroundColor) {
//        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
//        CGContextFillRect(context, bounds);
//    }else{
//        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//        CGContextFillRect(context, bounds);
//    }
//    
//    //边框
//    if (self.borderWidth > 0) {
//        CGContextAddPath(context, path.CGPath);
//        CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
//        CGContextSetLineWidth(context, self.borderWidth);
//        CGContextDrawPath(context, kCGPathFillStroke);
//    }
//
//    
//    CGContextRestoreGState(context);
}

@end
