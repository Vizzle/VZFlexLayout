//
//  VZFButtonNodeBackingLayer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFButtonNodeBackingLayer.h"

@implementation VZFButtonNodeBackingLayer

-(VZFButtonNodeRenderer *)renderer{
    if (!_renderer) {
        _renderer = [VZFButtonNodeRenderer new];
    }
    return  _renderer;
}


- (void)drawInContext:(CGContextRef)context parameters:(VZFButtonNodeRenderer *)renderer{
    CGRect boundsRect = CGContextGetClipBoundingBox(context);
    [_renderer drawInContext:context bounds:boundsRect];
}
@end
