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


-(void)setButtonStatus:(UIControlState)state{
    [[self buttonNodeBackingLayer].renderer updateRenderer:state maxSize:self.frame.size scale:self.layer.contentsScale];
    [[self buttonNodeBackingLayer] setNeedsAsyncDisplay];
}
-(void)setTitleFont:(UIFont *)font{
    [self buttonNodeBackingLayer].renderer.titleFont = font;
}
-(VZFButtonNodeBackingLayer *)buttonNodeBackingLayer{
    return (VZFButtonNodeBackingLayer *)self.layer;
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

- (__kindof VZFBaseRenderer *)renderer {
    return [self buttonNodeBackingLayer].renderer;
}

@end
