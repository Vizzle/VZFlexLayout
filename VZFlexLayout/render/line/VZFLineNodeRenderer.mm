//
//  VZFLineNodeRenderer.m
//  O2OReact
//
//  Created by pep on 2017/10/3.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "VZFLineNodeRenderer.h"

@implementation VZFLineNodeRenderer


- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds {
    CGFloat lineWidth;
    CGFloat x1, y1, x2, y2;
    if (bounds.size.width > bounds.size.height) {
        lineWidth = bounds.size.height;
        x1 = 0;
        x2 = bounds.size.width;
        y1 = y2 = lineWidth / 2;
    }
    else {
        lineWidth = bounds.size.width;
        y1 = 0;
        y2 = bounds.size.height;
        x1 = x2 = lineWidth / 2;
    }
    
    UIColor *lineColor = _color;
    if (!lineColor) {
        lineColor = [UIColor clearColor];
    }
    
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    if (_dashLength > 0 && _spaceLength > 0) {
        CGFloat lengths[] = {_dashLength, _spaceLength};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    CGContextMoveToPoint(context, x1, y1);
    CGContextAddLineToPoint(context, x2, y2);
    CGContextStrokePath(context);
    
    CGContextFillPath(context);
}



@end
