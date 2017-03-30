//
//  VZFAsyncLayer.h
//  VZFlexLayout
//
//  Created by moxin on 16/8/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "VZFAsyncDrawingTransactionInterface.h"
#import "VZFRenderer.h"
#import "VZFRasterizeCacheDefine.h"

typedef NS_ENUM(NSUInteger, VZFAsyncLayerDisplayMode) {

    kDisplayModeAsync,
    kDisplayModeSync
};


@protocol VZFAsyncLayerDrawingDelegate

- (void)drawAsyncLayerInContext:(CGContextRef)context parameters:(NSObject *)parameters;

@end


@interface VZFAsyncLayer : CALayer

/**
 设置同步还是异步绘制
 */
@property(nonatomic,assign) VZFAsyncLayerDisplayMode displayMode;
@property(nonatomic,assign) VZFRasterizeCachePolicy rasterizeCachePolicy;

/**
 @summary Captures parameters from the receiver on the main thread that will be passed to drawInContext:parameters:
 on a background queue.  Override to capture values from any properties that are needed for drawing.
 
 @returns The parameters.
 */
- (VZFRenderer *)drawParameters;

/**
 @summary Cancels any pending async display.
 
 @desc If the receiver has had display called and is waiting for the dispatched async display to be executed, this will
 cancel that dispatched async display.  This method is useful to call when removing the receiver from the window.
 */
- (void)cancelAsyncDisplay;
/**
 If contents is nil, this is the same as -setNeedsDisplay.
 If -setNeedsDisplay is called for any other reason during the same pass, it overrides any calls to
 -setNeedsAsyncDisplay and results in the default behavior of -setNeedsDisplay.
 
 Otherwise, redisplays the layer in the following manner:
 - Redisplay is always asynchronous.
 - Parent transaction containers are ignored.
 - The existing contents are left in the layer instead of being cleared during async display.
 
 This method can be used when the existing layer contents are valid, just out of date, so there is no need to clear
 contents or modify the parent transaction container.
 */
- (void)setNeedsAsyncDisplay;

- (void)drawInContext:(CGContextRef)context parameters:(NSObject *)parameters;

- (void)resetNextSyncDisplay;

@end

@interface VZFAsyncLayer(Subclass)

- (id)willDisplayAsynchronouslyWithDrawParameters:(id<NSObject>)drawParameters;

- (void)didDisplayAsynchronously:(id)newContents withDrawParameters:(id<NSObject>)drawParameters;



@end



