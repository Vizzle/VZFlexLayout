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
#import "VZFUtils.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"

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
        self.contentScaleFactor = VZ::Helper::screenScale();
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

- (VZFRenderer *)renderer {
    return self.imageRenderer;
}

- (void)setRenderer:(__kindof VZFRenderer *)renderer {
    if ([renderer isKindOfClass:[VZFImageNodeRenderer class]]) {
        [self imageLayer].renderer = (VZFImageNodeRenderer *)renderer;
    } else {
        [self imageLayer].renderer = nil;
    }
}


-(void)setLayerNeedsAsyncDisplay{
    [self.imageLayer setNeedsAsyncDisplay];
}

- (void)setImage:(UIImage *)image {
    if (!self.imageRenderer) {
        [super setImage:image];
    } else {
        if (image == self.imageRenderer.image) {
            return;
        }
        self.imageRenderer.image = image;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer setNeedsDisplay];
    }
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
- (void)vz_applyNodeAttributes:(VZFImageNode *)imageNode{
    ImageNodeSpecs imageSpec = imageNode.imageSpecs;
    id<VZFNetworkImageDownloadProtocol> imageDownloader = imageNode.imageDownloader;
    id<VZFNetworkImageDownloadProtocol> networkImageView = nil;
    
    //gif重复次数，context里拿到设置给imageView。setImage: 中会使用 animationRepeatCount，因此要先设置。
    NSDictionary *ctx = [imageSpec.context isKindOfClass:[NSDictionary class]] ? (NSDictionary *)imageSpec.context : @{};
    int animateCount = [ctx[@"animate-count"] intValue]?:0;
    
    // 这里不做判空，可能会在方法内做清理操作，避免复用可能会导致的图片错乱
    //just call protocol
    
    //FIXED
    NSAssert(!imageSpec.imageUrl ||[imageSpec.imageUrl isKindOfClass:[NSString class]], @"ImageNodeSpecs imageUrl should be a string");
    
    VZFImageNodeRenderer *renderer = nil;
    if ([self isKindOfClass:[VZFImageNodeBackingView class]]) {
        VZFImageNodeBackingView *view = (VZFImageNodeBackingView *)self;
        
        imageNode.renderer.animateCount = animateCount;
        imageNode.renderer.scale = self.contentScaleFactor;
        renderer = imageNode.renderer;
        
        view.imageRenderer = imageNode.renderer;
        view.contentMode = imageSpec.contentMode;
        
        networkImageView = view;
        
        if (imageSpec.imageUrl.length <= 0) {
            view.image = imageSpec.image;
        } else {
            view.image = nil;
        }
    } else {
        UIImageView<VZFNetworkImageDownloadProtocol>* view = (UIImageView<VZFNetworkImageDownloadProtocol>* )self;
        view.animationRepeatCount = animateCount;
        view.image = imageSpec.image;
        view.contentMode = imageSpec.contentMode;
        
        networkImageView = view;
    }
    
    // 这里不做判空，可能会在方法内做清理操作，避免复用可能会导致的图片错乱
    //just call protocol
    
    //FIXED
    NSAssert(!imageSpec.imageUrl ||[imageSpec.imageUrl isKindOfClass:[NSString class]], @"ImageNodeSpecs imageUrl should be a string");
    
    if ([imageSpec.imageUrl isKindOfClass:[NSString class]]){
        if (imageDownloader && renderer) {
            [imageDownloader vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl] size:self.bounds.size contentMode:imageSpec.contentMode placeholderImage:imageSpec.image errorImage:imageSpec.errorImage context:imageSpec.context completionBlock:renderer];
        }else{
            [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                            size:self.bounds.size
                                     contentMode:imageSpec.contentMode
                                placeholderImage:imageSpec.image
                                      errorImage:imageSpec.errorImage
                                         context:imageSpec.context
                                 completionBlock:imageSpec.completion];
        }
    }
}
@end
