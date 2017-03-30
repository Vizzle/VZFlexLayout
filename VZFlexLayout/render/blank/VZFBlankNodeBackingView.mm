//
//  VZFBlankNodeBackingView.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFBlankNodeBackingView.h"
#import "VZFBlankNodeBackingLayer.h"
#import "VZFUtils.h"
#import "VZFStackNode.h"
#import "VZFNodeInternal.h"
#import "VZFDispatch.h"

@implementation VZFBlankNodeBackingView

+ (Class)layerClass{
    return [VZFBlankNodeBackingLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set some sensible defaults for a text view
        self.contentScaleFactor = VZ::Helper::screenScale();
    }
    return self;
}


- (VZFBlankNodeBackingLayer* )blankLayer{
    return (VZFBlankNodeBackingLayer* )self.layer;
}


-(VZFBlankNodeRenderer *)blankRenderer{
    return [self blankLayer].renderer;
}

- (__kindof VZFRenderer *)renderer {
    return [self blankRenderer];
}

- (void)setCachePolicy:(VZFRasterizeCachePolicy)cachePolicy {
    self.blankLayer.rasterizeCachePolicy = cachePolicy;
}

- (void)setRenderer:(__kindof VZFRenderer *)renderer {
    if ([renderer isKindOfClass:[VZFBlankNodeRenderer class]]) {
        [self blankLayer].renderer = renderer;
    } else {
        [self blankLayer].renderer = nil;
    }
}

-(void)setLayerNeedsAsyncDisplay{
    [self.blankLayer setNeedsAsyncDisplay];
}


-(UIColor *)backgroundColor{
    return self.blankRenderer.backgroundColor;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
//    if (self.tag >=1000 && self.tag<=1003) {
//        NSLog(@"%@",backgroundColor);
//        NSLog(@"1");
//    }
    self.blankRenderer.backgroundColor = backgroundColor;
    [[self blankLayer] setNeedsDisplay];
}




-(void)setLayerBorder:(CGColorRef)color borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius>0) {
        [self blankLayer].opaque = NO;
    }
    self.blankRenderer.borderColor = [UIColor colorWithCGColor:color];
    self.blankRenderer.borderWidth = borderWidth;
    self.blankRenderer.customCorner = vzfRoundedCorner(cornerRadius);
    [[self blankLayer] setNeedsDisplay];
}

- (BOOL)isAccessibilityElement {
    if ([self renderer]) {
        return [[self renderer] checkIsAccessibilityElement];
    }
    return [super isAccessibilityElement];
}

- (NSString *)accessibilityLabel {
    if ([self renderer]) {
        return [[self renderer] compositeAccessibilityLabel];
    }
    return [super accessibilityLabel];
}

- (void)vz_applyNodeAttributes:(VZFStackNode *)node {
    if (![node isKindOfClass:[VZFStackNode class]]) {
        return;
    }
    
    self.defaultColor = node.specs.backgroundColor;
    self.highlightColor = node.specs.highlightBackgroundColor;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    if(self.highlightColor){
        [self setBackgroundColorSynchronously:self.highlightColor];
    }else{
        [self setBackgroundColorSynchronously:self.defaultColor];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    // 过一会儿再把背景颜色改回去，让用户能看到点击反馈
    VZFDispatchMain(0.1, ^{
        //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setBackgroundColorSynchronously:self.defaultColor];
    });
    
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    [super touchesCancelled:touches withEvent:event];
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    [self setBackgroundColorSynchronously:self.defaultColor];
}

- (void)setBackgroundColorSynchronously:(UIColor *)backgroundColor {
    if (backgroundColor == self.backgroundColor
        || [backgroundColor isEqual:self.backgroundColor]) {
        return;
    }
    
    [self.blankLayer resetNextSyncDisplay];
    self.backgroundColor = backgroundColor;
}


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)resetState
{
    self.backgroundColor = self.defaultColor;
}


@end
