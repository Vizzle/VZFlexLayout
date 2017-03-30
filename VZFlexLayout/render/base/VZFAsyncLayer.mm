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
#import "VZFNodeInternal.h"
#import "VZFImageCacheManager.h"

@interface VZFAsyncLayer()<VZFAsyncLayerDrawingDelegate>

@end

@implementation VZFAsyncLayer
{
    int32_t _displaySentinel;
    BOOL _needsAsyncDisplayOnly;

    NSNumber *_nextSyncDisplay;
    
    struct {
        BOOL valid;
        
        NSString *contentsGravity;
        BOOL masksToBounds;
    } _stashState;
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
//设置下次绘制使用同步机制
-(void)resetNextSyncDisplay{
    _nextSyncDisplay = @(YES);
}

-(BOOL)asyncDisplay{
    BOOL defaultValue = YES;
    if (_nextSyncDisplay) {
        BOOL r = ![_nextSyncDisplay boolValue];
        _nextSyncDisplay = nil;
        return r;
    }
    return defaultValue;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    [super setBorderWidth:0];
    VZFRenderer *renderer = self.drawParameters;
    if (borderWidth != renderer.borderWidth) {
        renderer.borderWidth = borderWidth;
        [self setNeedsDisplay];
    }
}

- (void)setBorderColor:(CGColorRef)borderColor {
    VZFRenderer *renderer = self.drawParameters;
    if (!CGColorEqualToColor(borderColor, renderer.borderColor.CGColor)) {
        renderer.borderColor = borderColor != NULL ? [UIColor colorWithCGColor:borderColor] : nil;
        [self setNeedsDisplay];
    }
}

- (void)setBackgroundColor:(CGColorRef)backgroundColor {
    [super setBackgroundColor:nil];
    VZFRenderer *renderer = self.drawParameters;
    if (!CGColorEqualToColor(backgroundColor, renderer.backgroundColor.CGColor)) {
        renderer.backgroundColor = backgroundColor != NULL ? [UIColor colorWithCGColor:backgroundColor] : nil;
        [self setNeedsDisplay];
    }
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    [super setMasksToBounds:masksToBounds];
    self.drawParameters.clip = masksToBounds;
    if (_stashState.valid) {
        _stashState.masksToBounds = masksToBounds;
    }
}

- (void)setContentsGravity:(NSString *)contentsGravity {
    [super setContentsGravity:contentsGravity];
    if (_stashState.valid) {
        _stashState.contentsGravity = contentsGravity;
    }
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
    //
    //    if (renderSynchronously) {
    //        [super display];
    //        return;
    //    }
    
    if (!_needsAsyncDisplayOnly) {
        
        // Reset needsDisplay to NO and remove any old content; otherwise it might appear stretched until rendering completes
        // 解决图片拉伸
        //self.contents = nil;
        
        UIImage *cache = self.drawParameters.node.cachedContents;
        BOOL needSetSontentsGravity = NO;
        if (cache && ((self.rasterizeCachePolicy & VZFRasterizeCachePolicyNode) > 0)) {
            self.contents = (__bridge id)(cache.CGImage);
            
            CGFloat scale = cache.scale;
            if (cache.size.width != self.bounds.size.width * scale
                || cache.size.height != self.bounds.size.height * scale) {
                needSetSontentsGravity = YES;
            }
            
        } else if(self.contents && ((self.rasterizeCachePolicy & VZFRasterizeCachePolicyLayer) > 0)) {
            needSetSontentsGravity = YES;
        } else {
            self.contents = nil;
        }
        
        if (needSetSontentsGravity) {
            _stashState = {.valid = NO, .contentsGravity = self.contentsGravity, .masksToBounds = self.masksToBounds};
            
            self.contentsGravity = kCAGravityBottomLeft;
            self.masksToBounds = YES;
            
            _stashState.valid = YES;//这一行必须放在最后，因为在contentsGravity和masksToBounds的set方法里会用到他
        }
    }
    CGRect bounds = self.bounds;
    if(CGRectIsEmpty(bounds)) {
        self.contents = nil;
        [self tryToRecoverState];
        return ;
    }
    
    VZFRenderer* drawParameters = [self drawParameters];
    if (!renderSynchronously) {
        id preloadContent = [self willDisplayAsynchronouslyWithDrawParameters:drawParameters];
        if (preloadContent) {
            self.contents = preloadContent;
            [self tryToRecoverState];
            return ;
        }
    }
    
    int32_t  displaySentinelValue = OSAtomicIncrement32(&_displaySentinel);
    CALayer* containerLayer = parentTransactionContainer?:self;
    vz_async_display_block_t displayBlock = [[self class] asyncDisplayBlockWithBounds:bounds
                                                                        contentsScale:self.contentsScale
                                                                               opaque:drawParameters.opaque
                                                                      backgroundColor:self.backgroundColor
                                                                      displaySentinel:&_displaySentinel
                                                         expectedDisplaySentinelValue:displaySentinelValue
                                                                      drawingDelegate:self
                                                                       drawParameters:drawParameters];
    
    
    vz_async_completion_block_t completionBlock = ^(id<NSObject> value, BOOL cancelled){
    
        VZFAssertMainThread();
        [self tryToRecoverState];
        if (!cancelled && (_displaySentinel == displaySentinelValue)) {
            [self didDisplayAsynchronously:value withDrawParameters:drawParameters];
            UIImage *image = [UIImage imageWithCGImage:(CGImageRef)value];
            self.contents = value;
            [[VZFImageCacheManager sharedInstance] storeContentsCache:image];
            self.drawParameters.node.cachedContents = image;
        }
    
    };
    
    if (renderSynchronously) {
        completionBlock(displayBlock(),NO);
    }else{
        VZFAsyncDrawingTransaction* transaction = containerLayer.asyncTransaction;
        VZFAssertNotNil(transaction, @"Transaction Cannot be nil!");
        [transaction addSyncDrawingOperation:displayBlock
                                       queue:[[self class]displayQueue]
                                  completion:completionBlock];
    }
    
}

//同步绘制
- (void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
    
    VZFAssertMainThread();
    [self drawInContext:ctx parameters:[self drawParameters]];
//    [self drawBorder:ctx];

}

- (void)tryToRecoverState {
    if (_stashState.valid) {
        _stashState.valid = NO;//必须放在第一个，因为在contentsGravity和masksToBounds中的set方法依赖这个
        self.contentsGravity = _stashState.contentsGravity;
        self.masksToBounds = _stashState.masksToBounds;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - public methods

- (VZFRenderer *)drawParameters{
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
    [self tryToRecoverState];
}


//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - transaction methods




//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - protocol methods

- (void)drawAsyncLayerInContext:(CGContextRef)context parameters:(NSObject *)parameters{
    
    [self drawInContext:context parameters:parameters];

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


@end
