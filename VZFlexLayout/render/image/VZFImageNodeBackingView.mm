//
//  VZFImageNodeBackingView.m
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFImageNodeBackingView.h"
#import "VZFImageNodeRenderer.h"
#import "VZFImageNodeBackingLayer.h"

@implementation VZFImageNodeBackingView

@dynamic imageRenderer;

+ (Class)layerClass{
    return [VZFImageNodeBackingLayer class];
}

- (VZFImageNodeBackingLayer* )imageLayer{
    return (VZFImageNodeBackingLayer* )self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Set some sensible defaults for a text view
    }
    return self;
}

- (void)setImageRenderer:(VZFImageNodeRenderer *)imageRenderer{
    
    [self imageLayer].renderer  = imageRenderer;
}

- (VZFImageNodeRenderer* )imageRenderer{
    return [self imageLayer].renderer;
}

- (void)setImage:(UIImage *)image {
    if (image == self.imageRenderer.image) {
        return;
    }
    self.imageRenderer.image = image;
    [self.layer setNeedsDisplay];
}

- (UIImage *)image {
    return self.imageRenderer.image;
}

@end
