//
//  VZFRasterizeNodeTool.m
//  VZFlexLayout
//
//  Created by heling on 2017/2/10.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFRasterizeNodeTool.h"
#import "VZFAsyncConfig.h"
#import "VZFImageNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFImageNodeRenderer.h"
#import "VZFTextNodeRenderer.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNodeSpecs.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFStackNode.h"
#import "VZFBlankNodeRenderer.h"
#import "VZFButtonNodeSpecs.h"

@implementation VZFRasterizeNodeTool

+(VZFRenderer *)getRenderer4RasterizedNode:(VZFNode *)node size:(CGSize)size {
    //判断光栅化开关
    if (!VZFUseRasterize) {
        return nil;
    }
    
    NodeSpecs specs = node.specs;
    if (specs.gesture ||
        specs.highlightBackgroundColor ||
        specs.borderWidth > 0 ||
        //(specs.clip && ([node isKindOfClass:[VZFStackNode class]] || [node  isMemberOfClass:[VZFNode class]]) ) ||
        specs.alpha < 1 ||
        specs.tag > 0 ||
        specs.applicator
//        ||(specs.isAccessibilityElement != VZF_BOOL_UNDEFINED && specs.isAccessibilityElement) ||
//        specs.accessibilityLabel
        ) {
        return nil;
    }
    
    if (!node.viewClass.hasView()) {
        return nil;
    }
        
    if ([node isKindOfClass:[VZFImageNode class]])
    {
        return [self getImageRenderer:((VZFImageNode* )node).imageSpecs node:(VZFImageNode *)node size:size];
    }
    else
        if ([node isKindOfClass:[VZFTextNode class]])
    {
        return [self getTextRenderer:((VZFTextNode* )node).textSpecs node:(VZFTextNode *)node size:size];
    }
    else if([node  isKindOfClass:[VZFStackNode class]] || ([node  isMemberOfClass:[VZFNode class]] && ![node hasCustomView])){
        return [self getBlankRenderer:(VZFStackNode *)node];
    }
    //button需要独立处理事件 需要view不做光栅化处理
    
    return nil;
}

+(VZFTextNodeRenderer *)getTextRenderer:(const TextNodeSpecs& )textNodeSpecs node:(VZFTextNode* )node size:(CGSize)size{
    VZFTextNodeRenderer *renderer = node.renderer;
    UIEdgeInsets edgeInsets = node.flexNode.resultPadding;
    renderer.edgeInsets = edgeInsets;
    renderer.maxSize = CGSizeMake(size.width - edgeInsets.left - edgeInsets.right,size.height - edgeInsets.top - edgeInsets.bottom);
    [self setRenderer:renderer specs:node.specs];
    return renderer;
}

+(VZFBlankNodeRenderer *)getBlankRenderer:(VZFStackNode *)node{
    VZFBlankNodeRenderer *renderer = [VZFBlankNodeRenderer new];
    [self setRenderer:renderer specs:node.specs];
    return renderer;
}

+(VZFImageNodeRenderer *)getImageRenderer:(const ImageNodeSpecs& )imageSpec node:(VZFImageNode* )node size:(CGSize)size{
    NSDictionary *ctx = [imageSpec.context isKindOfClass:[NSDictionary class]] ? (NSDictionary *)imageSpec.context : @{} ;
    int animateCount = [ctx[@"animate-count"] intValue]?:0;
    
    if (animateCount > 1) {
        return nil;
    }
    //这个情况需要一个view
    if(imageSpec.imageUrl.length && !node.imageDownloader){
        return nil;
    }
    
    //图片已经下载成功
    UIImage *downLoadImage = nil;
    if(node.downloadImage && [node.downloadImageUrl isEqualToString:imageSpec.imageUrl]){
        downLoadImage = node.downloadImage;
    }
    
    NSArray *images = downLoadImage.images;
    NSTimeInterval duration = downLoadImage.duration;
    
    if (images.count && duration) {
        //gif 图片 需要用view来处理
        return nil;
    }
    
    
    VZFImageNodeRenderer *renderer = node.renderer;
    if (!renderer) {
        renderer = [VZFImageNodeRenderer new];
    }
    renderer.animateCount = animateCount;
    renderer.scale = VZ::Helper::screenScale();
    renderer.contentMode = imageSpec.contentMode;
    renderer.image = imageSpec.image;
    
    [self setRenderer:renderer specs:node.specs];

    if (imageSpec.imageUrl.length) {
        //已经下载成功 并缓存 直接赋值
        if (downLoadImage) {
            renderer.image = downLoadImage;
        }else{
            [node.imageDownloader vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl] size:size contentMode:renderer.contentMode  placeholderImage:imageSpec.image errorImage:imageSpec.errorImage context:imageSpec.context completionBlock:renderer];
            if([renderer.downloadImageUrl isEqualToString:imageSpec.imageUrl]){
                //同步回调 在node缓存image
                node.downloadImageUrl = renderer.downloadImageUrl;
                node.downloadImage = renderer.image;
                if (node.downloadImage.images.count) {
                    return nil;
                }
            }
        }
    }
    
    return renderer;
}



+(void)setRenderer:(VZFRenderer *)renderer specs:(const NodeSpecs&)vs{
    renderer.backgroundColor = vs.backgroundColor;
    renderer.borderWidth = vs.borderWidth;
    renderer.borderColor = vs.borderColor;
    renderer.customCorner = vzfRoundedCorner(vs.cornerRadius);
    renderer.clip = vs.clip;
  
    BOOL isTextRenderer = [renderer isKindOfClass:[VZFTextNodeRenderer class]];
    if (vs.isAccessibilityElement != VZF_BOOL_UNDEFINED) {
        renderer.isAccessibilityElement = vs.isAccessibilityElement;
    } else {
        //VZFTextNodeRenderer默认为YES
        renderer.isAccessibilityElement = isTextRenderer;
    }
    
    renderer.accessibilityLabel = vs.accessibilityLabel;
    if (renderer.accessibilityLabel.length <= 0
        && isTextRenderer) {
        renderer.accessibilityLabel = [[(VZFTextNodeRenderer *)renderer text] string];
    }
}

@end
