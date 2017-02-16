//
//  VZFRasterizeLayer.m
//  VZFlexLayout
//
//  Created by pep on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFRasterizeLayer.h"
#import "VZFRenderer.h"
#import "VZFMacros.h"

@implementation VZFRasterizeLayer

#pragma mark - setter methods

- (void)setRenderer:(VZFRenderer *)renderer{
    
    VZFAssertMainThread();
    
    //    if (!renderer) {
    //        return ;
    //    }
    //
    //    if (_renderer != renderer) {
    //        if (renderer.specs == _renderer.specs) {
    //
    //            _renderer = renderer;
    //            return;
    //        }
    //        else{
    //            self.contents = nil;
    //        }
    //    }
    _renderer = renderer;
    [self setNeedsAsyncDisplay];
    
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - override methods

- (VZFRenderer* )drawParameters{
    
    return _renderer;
}

- (void)drawInContext:(CGContextRef)context parameters:(VZFRenderer *)renderer{
    
    CGRect boundsRect = CGContextGetClipBoundingBox(context);
    [renderer drawInContext:context bounds:boundsRect];
}


@end
