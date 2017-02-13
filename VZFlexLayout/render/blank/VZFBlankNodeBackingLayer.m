//
//  VZFBlankNodeBackingLayer.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFBlankNodeBackingLayer.h"

@implementation VZFBlankNodeBackingLayer

-(VZFBlankNodeRenderer *)renderer{
    if (!_renderer) {
        _renderer = [VZFBlankNodeRenderer new];
    }
    return _renderer;
}


- (NSObject* )drawParameters{
    
    return _renderer;
}

- (void)drawInContext:(CGContextRef)context parameters:(VZFBlankNodeRenderer *)renderer{
    
    CGRect boundsRect = CGContextGetClipBoundingBox(context);
    [_renderer drawInContext:context bounds:boundsRect];
}

- (void)drawInContext:(CGContextRef)ctx{

    [super drawInContext:ctx];
}

@end
