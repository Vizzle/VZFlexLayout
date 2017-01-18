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
    //顺序不能调整
    if (imageRenderer) {
        [self setImage:nil];
    }
    [self imageLayer].renderer  = imageRenderer;
}

- (VZFImageNodeRenderer* )imageRenderer{
    return [self imageLayer].renderer;
}

- (void)setImage:(UIImage *)image {
    if (!self.imageRenderer) {
        [super setImage:image];
    } else {
        if (image == self.imageRenderer.image) {
            return;
        }
        self.imageRenderer.image = image;
        [self.layer setNeedsDisplay];
    }
}

- (UIImage *)image {
    if (!self.imageRenderer) {
        return [super image];
    } else {
        return self.imageRenderer.image;
    }
}

@end
