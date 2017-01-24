//
//  VZFBaseRenderer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFBaseRenderer.h"

@implementation VZFBaseRenderer


//can not override by sub class
- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds {
    [self drawBackgroundColor:context bounds:bounds];
    [self drawContentInContext:context bounds:bounds];
    [self drawBorder:context bounds:bounds];
}

- (void)drawBackgroundColor:(CGContextRef)context bounds:(CGRect)bounds {
    if (!self.backgroundColor) {
        return;
    }
    
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, bounds);
    
    CGContextRestoreGState(context);
}

- (void)drawBorder:(CGContextRef)context bounds:(CGRect)bounds {
    if (self.borderWidth <= 0 || !self.borderColor) {
        return;
    }
    
    CGContextSaveGState(context);
    
    if (self.cornerRadius > 0) {
        CGFloat cornerRadius = self.cornerRadius;
        CGFloat halfHeight = bounds.size.height * 0.5;
        CGFloat halfWidth = bounds.size.width * 0.5;
        
        CGFloat xAngle = 0;
        if (cornerRadius > halfWidth) {
            xAngle = asin((cornerRadius - halfWidth) / cornerRadius);
        }
        
        CGFloat yAngle = 0;
        if (cornerRadius > halfHeight) {
            yAngle = asin((cornerRadius  - halfHeight) / cornerRadius);
        }
        
        
        CGContextBeginPath(context); //begin an empty path
        
        /*
         If the current path already contains a subpath, this method adds a line connecting the current point to the starting point of the arc. If the current path is empty, his method creates a new subpath whose starting point is the starting point of the arc. The ending point of the arc becomes the new current point of the path.
         */
        //left top corner
        CGContextAddArc(context, cornerRadius, cornerRadius, cornerRadius, M_PI + yAngle, M_PI_2 * 3 - xAngle, NO);
        
        //left right corner
        CGContextAddArc(context, bounds.size.width - cornerRadius, cornerRadius, cornerRadius, - M_PI_2 + xAngle, - yAngle, NO);
        
        //right bottom corner
        CGContextAddArc(context, bounds.size.width - cornerRadius, bounds.size.height - cornerRadius, cornerRadius, 0 + yAngle, M_PI_2 - xAngle, NO);
        
        //left bottom corner
        CGContextAddArc(context, cornerRadius, bounds.size.height - cornerRadius, cornerRadius, M_PI_2 + xAngle, M_PI - yAngle, NO);
        CGContextClosePath(context);
        
        CGPathRef path = CGContextCopyPath(context);//store path
        CGContextClip(context);//clip and clear path
        CGContextAddPath(context, path);//recover path
        
    } else {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
        [path addClip];
        CGContextAddPath(context, path.CGPath);
    };
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    //we have set bounds as the clip path.So we set 2 times line width, and clip 1 time width lefting 1 time width;
    CGContextSetLineWidth(context, self.borderWidth * 2);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextRestoreGState(context);
}


- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds {
    //overrided by sub class
}

@end
