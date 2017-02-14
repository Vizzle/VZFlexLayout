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
-(void)setLayerNeedsAsyncDisplay{
    [self.blankLayer setNeedsAsyncDisplay];
}


-(UIColor *)backgroundColor{
    return self.blankRenderer.backgroundColor;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
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
@end
