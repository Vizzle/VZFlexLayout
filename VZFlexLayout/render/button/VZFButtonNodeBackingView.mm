//
//  VZFButtonNodeBackingView.m
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFButtonNodeBackingView.h"
#import "VZFButtonNodeBackingLayer.h"
#import "VZFUtils.h"

@implementation VZFButtonNodeBackingView

+(Class)layerClass{
    return [VZFButtonNodeBackingLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set some sensible defaults for a text view
        self.contentScaleFactor = VZ::Helper::screenScale();
    }
    return self;
}

-(VZFButtonNodeBackingLayer *)buttonNodeBackingLayer{
    return (VZFButtonNodeBackingLayer *)self.layer;
}
-(void)setLayerNeedsAsyncDisplay{
    [self.buttonNodeBackingLayer setNeedsAsyncDisplay];
}


-(void)setButtonStatus:(UIControlState)state{
    [[self buttonNodeBackingLayer].renderer updateRenderer:state maxSize:self.frame.size scale:self.layer.contentsScale];
    [self.buttonNodeBackingLayer setNeedsDisplay];
}

-(void)setTitleFont:(UIFont *)font{
    [self buttonNodeBackingLayer].renderer.titleFont = font;
}
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [[self buttonNodeBackingLayer].renderer setTitleColor:color forState:state];
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [[self buttonNodeBackingLayer].renderer setTitle:title forState:state];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [[self buttonNodeBackingLayer].renderer setImage:image forState:state];
}

-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    [[self buttonNodeBackingLayer].renderer setBackgroundImage:image forState:state];
}

- (__kindof VZFRenderer *)renderer {
    return [self buttonNodeBackingLayer].renderer;
}

- (void)setRenderer:(__kindof VZFRenderer *)renderer {
    if ([renderer isKindOfClass:[VZFButtonNodeRenderer class]]) {
        [self buttonNodeBackingLayer].renderer = renderer;
    } else {
        [self buttonNodeBackingLayer].renderer = nil;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [[self buttonNodeBackingLayer] resetNextSyncDisplay];
    [self setButtonStatus:UIControlStateNormal];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self buttonNodeBackingLayer] resetNextSyncDisplay];
    [self setButtonStatus:UIControlStateNormal];
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // If we get more than one touch down on us, cancel.
    // Additionally, if we're already tracking a touch, a second touch beginning is cause for cancellation.
    if ([touches count] > 1 || self.tracking)
    {
    }
    else
    {
        [[self buttonNodeBackingLayer] resetNextSyncDisplay];
        [self setButtonStatus:UIControlStateHighlighted];
    }
    
    [super touchesBegan:touches withEvent:event];

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

@end
