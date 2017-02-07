//
//  VZFImageNodeBackingLayer.m
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFImageNodeBackingLayer.h"
#import "VZFImageNodeRenderer.h"
#import "VZFMacros.h"

@implementation VZFImageNodeBackingLayer

-(VZFAsyncLayerDisplayMode)displayMode{
    if (_renderer.animateCount > 0) {
        return kDisplayModeSync;
    }
    
    return [super displayMode];
}


#pragma mark - setter methods

- (void)setRenderer:(VZFImageNodeRenderer *)renderer{
    
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

- (NSObject* )drawParameters{
    
    return _renderer;
}

- (void)drawInContext:(CGContextRef)context parameters:(VZFImageNodeRenderer *)renderer{
    
    CGRect boundsRect = CGContextGetClipBoundingBox(context);
//    boundsRect.origin.x += _edgeInsets.left;
//    boundsRect.origin.y += _edgeInsets.top;
//    boundsRect.size.width -= _edgeInsets.left + _edgeInsets.right;
//    boundsRect.size.height -= _edgeInsets.top + _edgeInsets.bottom;
    [renderer drawInContext:context bounds:boundsRect];
    
}

- (void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - subclassing methods

- (id)willDisplayAsynchronouslyWithDrawParameters:(id<NSObject>)drawParameters{
    
    return nil;
}

- (void)didDisplayAsynchronously:(id)newContents withDrawParameters:(id<NSObject>)drawParameters{
    
    //noop
}



@end
