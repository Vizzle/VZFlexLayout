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

-(BOOL)asyncDisplay{
    return NO;
//    return _renderer.animateCount <= 0;
}
//
//- (void)display {
//    VZFAssertMainThread();
//    
//    if (![self asyncDisplay]) {
//        self.contents = _renderer.image;
//        switch (_renderer.contentMode) {
//            case UIViewContentModeRedraw:
//            case UIViewContentModeScaleToFill:
//                self.contentsGravity = kCAGravityResize;
//                break;
//            case UIViewContentModeScaleAspectFill:
//                self.contentsGravity = kCAGravityResizeAspectFill;
//                break;
//            case UIViewContentModeScaleAspectFit:
//                self.contentsGravity = kCAGravityResizeAspect;
//                break;
//            case UIViewContentModeCenter:
//                self.contentsGravity = kCAGravityCenter;
//                break;
//            case UIViewContentModeLeft:
//                self.contentsGravity = kCAGravityLeft;
//                break;
//            case UIViewContentModeRight:
//                self.contentsGravity = kCAGravityRight;
//                break;
//            case UIViewContentModeTop:
//                self.contentsGravity = kCAGravityTop;
//                break;
//            case UIViewContentModeBottom:
//                self.contentsGravity = kCAGravityBottom;
//                break;
//            case UIViewContentModeTopLeft:
//                self.contentsGravity = kCAGravityTopLeft;
//                break;
//            case UIViewContentModeTopRight:
//                self.contentsGravity = kCAGravityTopRight;
//                break;
//            case UIViewContentModeBottomLeft:
//                self.contentsGravity = kCAGravityBottomLeft;
//                break;
//            case UIViewContentModeBottomRight:
//                self.contentsGravity = kCAGravityBottomRight;
//                break;
//            default:
//                break;
//        }
//    } else {
//        [super display];
//    }
//
//}

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
