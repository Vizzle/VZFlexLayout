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

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds parameters:(VZFBlankNodeRenderer *)renderer{
    
    [_renderer drawInContext:context bounds:bounds];
}

- (void)drawInContext:(CGContextRef)ctx{

    [super drawInContext:ctx];
}

@end
