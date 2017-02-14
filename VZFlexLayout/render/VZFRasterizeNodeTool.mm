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

@implementation VZFRasterizeNodeTool

+(VZFRenderer *)getRenderer4RasterizedNode:(VZFNode *)node{
    //判断光栅化开关
    if (!VZFUseRasterize) {
        return nil;
    }
        
    if ([node isKindOfClass:[VZFImageNode class]])
    {
        return [self getImageRender:((VZFImageNode* )node).imageSpecs node:node];
    }
    else if ([node isKindOfClass:[VZFTextNode class]])
    {
        return [self getTextRender:((VZFTextNode* )node).textSpecs node:node];
    }
    else if([node  isKindOfClass:[VZFStackNode class]]){
        return [self getBlankRender:node];
    }
    
    return nil;
}

+(VZFTextNodeRenderer *)getTextRender:(const TextNodeSpecs& )textNodeSpecs node:(VZFTextNode* )node{
    VZFTextNodeRenderer *renderer = node.renderer;
    UIEdgeInsets edgeInsets = node.flexNode.resultPadding;
//    textRenderer.maxWidth = self.bounds.size.width - label.edgeInsets.left - label.edgeInsets.right;
    [self setRender:renderer specs:node.specs];
    return renderer;
}

+(VZFBlankNodeRenderer *)getBlankRender:(VZFStackNode *)node{
    VZFBlankNodeRenderer *renderer = [VZFBlankNodeRenderer new];
    [self setRender:renderer specs:node.specs];
    return renderer;
}

+(VZFImageNodeRenderer *)getImageRender:(const ImageNodeSpecs& )imageSpec node:(VZFImageNode* )node{
    NSDictionary *ctx = [imageSpec.context isKindOfClass:[NSDictionary class]] ? (NSDictionary *)imageSpec.context : @{} ;
    int animateCount = [ctx[@"animate-count"] intValue]?:0;
    
    if (animateCount > 1 || imageSpec.imageUrl.length > 0) {
        return nil;
    }
    
    VZFImageNodeRenderer *renderer = [VZFImageNodeRenderer new];
    renderer.animateCount = animateCount;
    renderer.scale = VZ::Helper::screenScale();
    renderer.contentMode = imageSpec.contentMode;
    renderer.image = imageSpec.image;
    [self setRender:renderer specs:node.specs];
    return renderer;
}



+(void)setRender:(VZFRenderer *)renderer specs:(const NodeSpecs&)vs{
    renderer.backgroundColor = vs.backgroundColor;
    renderer.borderWidth = vs.borderWidth;
    renderer.borderColor = vs.borderColor;
    renderer.customCorner = vzfRoundedCorner(vs.cornerRadius);
    renderer.clip = vs.clip;
}

@end
