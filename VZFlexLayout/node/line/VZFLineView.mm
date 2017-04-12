//
//  VZFLineView.m
//  O2OReact
//
//  Created by Sleen on 16/8/5.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFLineView.h"
#import "UIView+VZAttributes.h"
#import "VZFLineNode.h"

@implementation VZFLineView

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setDashLength:(CGFloat)dashLength {
    _dashLength = dashLength;
    [self setNeedsDisplay];
}

- (void)setSpaceLength:(CGFloat)spaceLength {
    _spaceLength = spaceLength;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat lineWidth;
    CGFloat x1, y1, x2, y2;
    if (rect.size.width > rect.size.height) {
        lineWidth = rect.size.height;
        x1 = 0;
        x2 = rect.size.width;
        y1 = y2 = lineWidth / 2;
    }
    else {
        lineWidth = rect.size.width;
        y1 = 0;
        y2 = rect.size.height;
        x1 = x2 = lineWidth / 2;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
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

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    LineNodeSpecs specs = ((VZFLineNode *)node).lineSpecs;
    self.color = specs.color;
    self.dashLength = specs.dashLength;
    self.spaceLength = specs.spaceLength;
}

@end
