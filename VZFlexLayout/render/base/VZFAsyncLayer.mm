//
//  VZFAsyncLayer.m
//  VZFlexLayout
//
//  Created by moxin on 16/8/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFAsyncLayer.h"
#import "VZFMacros.h"
#import "VZFUtils.h"
#import "VZFAsyncDrawingTransaction.h"
#import "VZFAsyncDrawingTransactionContainer.h"
#import "VZFAsyncDrawingTransactionContainer+Private.h"
#import <libkern/OSAtomic.h>
#import <UIKit/UIKit.h>

@interface VZFAsyncLayer()<VZFAsyncLayerDrawingDelegate>

@end

@implementation VZFAsyncLayer
{
    int32_t _displaySentinel;
    BOOL _needsAsyncDisplayOnly;
    CGFloat _realBorderWidth;
}


+ (dispatch_queue_t)displayQueue
{
    static dispatch_queue_t displayQueue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        displayQueue = dispatch_queue_create("com.O2O.VZFAsyncLayer.display", DISPATCH_QUEUE_CONCURRENT);
        // we use the highpri queue to prioritize UI rendering over other async operations
        dispatch_set_target_queue(displayQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    });
    
    return displayQueue;
}


+ (nullable id)defaultValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"displayMode"]) {
        return @(kDisplayModeSync);
    } else {
        return [super defaultValueForKey:key];
    }
}





///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - override CALayer's method

- (void)setNeedsDisplay{

    VZFAssertMainThread();
    
    [self cancelAsyncDisplay];
    [super setNeedsDisplay];
    
    _needsAsyncDisplayOnly = NO;
}

-(BOOL)asyncDisplay{
    return YES;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _realBorderWidth = borderWidth;
    [super setBorderWidth:0];
}

- (void)display{

    VZFAssertMainThread();
    
    BOOL renderSynchronously = ![self asyncDisplay];
    CALayer* parentTransactionContainer = nil;
    
    if (!_needsAsyncDisplayOnly) {
        
        switch (self.displayMode) {
            case kDisplayModeSync:
                renderSynchronously = YES;
                break;
            case kDisplayModeAsync:
                parentTransactionContainer = self.parentTransactionContainer;
                break;
            default:
                renderSynchronously = YES;
                break;
        }
    }
    
    if (renderSynchronously) {
        [super display];
        return;
    }
    
    if (!_needsAsyncDisplayOnly) {
        
        // Reset needsDisplay to NO and remove any old content; otherwise it might appear stretched until rendering completes
        // 解决图片拉伸
        self.contents = nil;
    }
    CGRect bounds = self.bounds;
    if(CGRectIsEmpty(bounds)) {
        return ;
    }
    
    NSObject* drawParameters = [self drawParameters];
    id preloadContent = [self willDisplayAsynchronouslyWithDrawParameters:drawParameters];
    if (preloadContent) {
        self.contents = preloadContent;
        return ;
    }
    
    int32_t  displaySentinelValue = OSAtomicIncrement32(&_displaySentinel);
    CALayer* containerLayer = parentTransactionContainer?:self;
    VZFAsyncDrawingTransaction* transaction = containerLayer.asyncTransaction;
    VZFAssertNotNil(transaction, @"Transaction Cannot be nil!");
    vz_async_display_block_t displayBlock = [[self class] asyncDisplayBlockWithBounds:bounds
                                                                        contentsScale:self.contentsScale
                                                                               opaque:self.opaque
                                                                      backgroundColor:self.backgroundColor
                                                                      displaySentinel:&_displaySentinel
                                                         expectedDisplaySentinelValue:displaySentinelValue
                                                                      drawingDelegate:self
                                                                       drawParameters:drawParameters];
    
    
    vz_async_completion_block_t completionBlock = ^(id<NSObject> value, BOOL cancelled){
    
        VZFAssertMainThread();
        if (!cancelled && (_displaySentinel == displaySentinelValue)) {
            [self didDisplayAsynchronously:value withDrawParameters:drawParameters];
            UIImage *im = [UIImage imageWithCGImage:(CGImageRef)value];
            self.contents = value;
        }
    
    };
    
    [transaction addSyncDrawingOperation:displayBlock
                                   queue:[[self class]displayQueue]
                              completion:completionBlock];
    
}

//同步绘制
- (void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
    
    VZFAssertMainThread();
    [self drawInContext:ctx parameters:[self drawParameters]];
    [self drawBorder:ctx];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - public methods

- (NSObject *)drawParameters{
    return nil;
}

- (void)setNeedsAsyncDisplay{
    
    VZFAssertMainThread();
    
    if ([self needsDisplay]) {
        return ;
    }
    
    [self cancelAsyncDisplay];
    [super setNeedsDisplay];
    _needsAsyncDisplayOnly = YES;

}

- (void)cancelAsyncDisplay
{
    VZFAssertMainThread();
    OSAtomicIncrement32(&_displaySentinel);
}


//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - transaction methods




//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - protocol methods

- (void)drawAsyncLayerInContext:(CGContextRef)context parameters:(NSObject *)parameters{
    [self drawInContext:context parameters:parameters];
    [self drawBorder:context];
}



//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - subclassing methods

- (id)willDisplayAsynchronouslyWithDrawParameters:(id<NSObject>)drawParameters
{
    return nil;
}

- (void)didDisplayAsynchronously:(id)newContents withDrawParameters:(id<NSObject>)drawParameters
{
    
}

- (void)drawInContext:(CGContextRef)context parameters:(NSObject *)parameters{



}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - private methods


+ (vz_async_display_block_t)asyncDisplayBlockWithBounds:(CGRect)bounds
                                          contentsScale:(CGFloat)contentsScale
                                               opaque:(BOOL)opaque
                                      backgroundColor:(CGColorRef)backgroundColor
                                      displaySentinel:(int32_t *)displaySentinel
                         expectedDisplaySentinelValue:(int32_t)expectedDisplaySentinelValue
                                      drawingDelegate:(id<VZFAsyncLayerDrawingDelegate>)drawingDelegate
                                       drawParameters:(NSObject *)drawParameters{
    
    
    // make this an id so the block will capture it
    id backgroundColorObject = (__bridge id)backgroundColor;
    return [^id{
        // Short-circuit to be efficient in the case where we've already started a different -display.
        if ((displaySentinel != nil) && (*displaySentinel != expectedDisplaySentinelValue)) {
            return nil;
        }
        
        if (CGRectIsEmpty(bounds)) {
            return nil;
        }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, contentsScale);
        CGContextRef bitmapContext = UIGraphicsGetCurrentContext();
        
        if (backgroundColorObject != NULL) {
            CGContextSetFillColorWithColor(bitmapContext, (CGColorRef)backgroundColorObject);
            CGContextFillRect(bitmapContext, bounds);
        }
        
        [drawingDelegate drawAsyncLayerInContext:bitmapContext parameters:drawParameters];
        
        CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
        UIGraphicsEndImageContext();
        
        return CFBridgingRelease(image);
    } copy];

    

}

- (void)drawBorder:(CGContextRef)context {
    if (_realBorderWidth <= 0 || !self.borderColor) {
        return;
    }
    
    CGContextSaveGState(context);
    CGContextBeginPath(context);

    UIBezierPath *path = nil;
    CGRect rect = CGRectMake(_realBorderWidth * 0.5, _realBorderWidth * 0.5, self.bounds.size.width - _realBorderWidth, self.bounds.size.height - _realBorderWidth);
    if (self.cornerRadius > 0) {
        CGFloat offset = _realBorderWidth * 0.5;
        CGFloat cornerRadius = self.cornerRadius - offset;
        CGFloat halfHeight = self.bounds.size.height * 0.5;
        CGFloat halfWidth = self.bounds.size.width * 0.5;
        
        CGFloat xAngle = 0;
        if (cornerRadius + offset > halfWidth) {
            xAngle = asin((cornerRadius + offset - halfWidth) / cornerRadius);
        }
        
        CGFloat yAngle = 0;
        if (cornerRadius + offset > halfHeight) {
            yAngle = asin((cornerRadius  + offset  - halfHeight) / cornerRadius);
        }
        
        
        //左上角
        CGContextAddArc(context, cornerRadius + offset, cornerRadius + offset, cornerRadius, M_PI + yAngle, M_PI_2 * 3 - xAngle, NO);
        
        //右上角
        CGContextAddArc(context, self.bounds.size.width - cornerRadius - offset, cornerRadius + offset, cornerRadius, - M_PI_2 + xAngle, - yAngle, NO);
        
        //右下角
        CGContextAddArc(context, self.bounds.size.width - cornerRadius - offset, self.bounds.size.height - cornerRadius - offset, cornerRadius, 0 + yAngle, M_PI_2 - xAngle, NO);
        
        //左下角
        CGContextAddArc(context, cornerRadius + offset, self.bounds.size.height - cornerRadius - offset, cornerRadius, M_PI_2 + xAngle, M_PI - yAngle, NO);
        CGContextClosePath(context);
        
        
        
        
//        CGContextMoveToPoint(context, offset, halfHeight);
//        //先画左上角
//        CGContextAddArc(context, cornerRadius + offset, cornerRadius + offset, cornerRadius, M_PI, M_PI_2 * 3, NO);
//        
//        CGContextAddLineToPoint(context, self.bounds.size.width - cornerRadius, offset);
//        CGContextAddArc(context, self.bounds.size.width - cornerRadius - offset, cornerRadius + offset, cornerRadius, - M_PI_2, 0, NO);
//        
//        CGContextAddLineToPoint(context, self.bounds.size.width - offset, self.bounds.size.height - cornerRadius);
//
//        CGContextAddArc(context, self.bounds.size.width - cornerRadius - offset, self.bounds.size.height - cornerRadius - offset, cornerRadius, 0, M_PI_2, NO);
//        
//        CGContextAddLineToPoint(context, cornerRadius, self.bounds.size.height - offset);
//
//        CGContextAddArc(context, cornerRadius + offset, self.bounds.size.height - cornerRadius - offset, cornerRadius, M_PI_2, M_PI, NO);
//        
//        CGContextClosePath(context);
        


    } else {
        path = [UIBezierPath bezierPathWithRect:rect];
        CGContextAddPath(context, path.CGPath);
    };
    
    CGContextSetStrokeColorWithColor(context, self.borderColor);
    CGContextSetLineWidth(context, _realBorderWidth);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextRestoreGState(context);
}


@end
