//
//  VZFRasterizeView.m
//  VZFlexLayout
//
//  Created by pep on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFRasterizeView.h"
#import "VZFRenderer.h"
#import "VZFRasterizeLayer.h"
#import "VZFUtils.h"

@implementation VZFRasterizeView

@dynamic rootRenderer;

+ (Class)layerClass{
    return [VZFRasterizeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentScaleFactor = VZ::Helper::screenScale();
    }
    return self;
}

- (VZFRasterizeLayer *)rasterizeLayer {
    return (VZFRasterizeLayer *)(self.layer);
}

- (void)setRootRenderer:(VZFRenderer *)rootRenderer {
    [[self rasterizeLayer] setRenderer:rootRenderer];
}

- (VZFRenderer *)rootRenderer {
    return [[self rasterizeLayer] renderer];
}

@end
