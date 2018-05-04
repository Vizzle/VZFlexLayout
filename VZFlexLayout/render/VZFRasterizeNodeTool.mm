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
#import "VZFTextNodeRenderer.h"
#import "VZFImageNodeSpecs.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFStackNode.h"
#import "VZFBlankNodeRenderer.h"
#import "VZFButtonNodeSpecs.h"
#import "VZFImageNodeInternal.h"
#import "VZFTextNodeInternal.h"
#import "VZFLineNode.h"
#import "VZFLineNodeRenderer.h"
#import "VZFLineNodeSpecs.h"

#import <stack>



@interface VZFLayoutCheckResult : NSObject

@property (nonatomic, assign) BOOL hasOutOfBoundsChildren; //子孙中是否包含不能被光栅化的结点,并且这个结点与最近的clip为YES的祖先结点之间存在不能被光栅化的结点（不包括那个祖先结点，包括超出的子结点）
@property (nonatomic, assign) BOOL selfCanBeRasterized; //当前结点是否能被光栅化

@property (nonatomic, assign) BOOL childrenCannotBeRasterized; //父类如果有一个子节点不能被光栅化，那么从这个子节点往后都不能被光栅化


@end

@implementation VZFLayoutCheckResult


@end


@implementation VZFRasterizeNodeTool

+ (BOOL)canBeRasterized:(VZFNode *)node {
    //判断光栅化开关
    if (!VZFUseRasterize) {
        return NO;
    }
    
    NodeSpecs specs = node.specs;
    if (specs.gesture ||
        !specs.gestures.empty() ||
        specs.display ||
        specs.highlightBackgroundColor ||
        //specs.borderWidth > 0 ||
        //(specs.clip && ([node isKindOfClass:[VZFStackNode class]] || [node  isMemberOfClass:[VZFNode class]]) ) ||
        specs.alpha < 1 ||
        specs.tag > 0 ||
        specs.applicator
        //        ||(specs.isAccessibilityElement != VZF_BOOL_UNDEFINED && specs.isAccessibilityElement) ||
        //        specs.accessibilityLabel
        ) {
        return NO;
    }
    
    if (!node.viewClass.hasView()) {
        return NO;
    }
    
    if ([node isKindOfClass:[VZFImageNode class]])
    {
        return YES;
    }
    else if ([node isKindOfClass:[VZFTextNode class]])
    {
        return !((VZFTextNode *)node).textSpecs.linkAction;
    }
    else if ([node isKindOfClass:[VZFLineNode class]])
    {
        return YES;
    }
    else if([node  isKindOfClass:[VZFStackNode class]] || ([node  isMemberOfClass:[VZFNode class]] && ([@"VZFBlankNodeBackingView" isEqualToString:node.viewClass.identifier()] || [@"UIView" isEqualToString:node.viewClass.identifier()])) ){
        return YES;
    }
    //button需要独立处理事件 需要view不做光栅化处理
    
    return NO;
}



+(VZFRenderer *)getRenderer4RasterizedNode:(VZFNode *)node size:(CGSize)size {
    //判断光栅化开关
    if (![self canBeRasterized:node]) {
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
        else if([node  isKindOfClass:[VZFStackNode class]] || ([node  isMemberOfClass:[VZFNode class]] && ([@"VZFBlankNodeBackingView" isEqualToString:node.viewClass.identifier()] || [@"UIView" isEqualToString:node.viewClass.identifier()]))){
            return [self getBlankRenderer:(VZFStackNode *)node];
        }
        else if ([node isKindOfClass:[VZFLineNode class]])
        {
            return [self getLineRenderer:[(VZFLineNode *)node lineSpecs] node:(VZFLineNode *)node size:size];
        }
    //button需要独立处理事件 需要view不做光栅化处理
    
    return nil;
}

+(VZFLineNodeRenderer *)getLineRenderer:(const LineNodeSpecs& )lineNodeSpecs node:(VZFLineNode* )node size:(CGSize)size{
    VZFLineNodeRenderer *renderer = [VZFLineNodeRenderer new];
    renderer.color = lineNodeSpecs.color;
    renderer.dashLength = lineNodeSpecs.dashLength;
    renderer.spaceLength = lineNodeSpecs.spaceLength;
    [self setRenderer:renderer specs:node.specs];
    
    return renderer;
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
    BOOL isErrorImage = NO;
    if(node.downloadImage && [node.downloadImageUrl isEqualToString:imageSpec.imageUrl]){
        downLoadImage = node.downloadImage;
    } else if (node.errorImage) {
        downLoadImage = node.errorImage;
        isErrorImage = YES;
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
    renderer.completion = imageSpec.completion;
    
    [self setRenderer:renderer specs:node.specs];
    
    if (imageSpec.imageUrl.length) {
        //已经下载成功 并缓存 直接赋值
        if (downLoadImage) {
            renderer.image = downLoadImage;
            renderer.isErrorImage = isErrorImage;
        }else{
            [node.imageDownloader vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl] size:size contentMode:renderer.contentMode  placeholderImage:imageSpec.image errorImage:imageSpec.errorImage context:imageSpec.context completionBlock:renderer];
            if([renderer.downloadImageUrl isEqualToString:imageSpec.imageUrl]){
                //同步回调 在node缓存image
                node.downloadImageUrl = renderer.downloadImageUrl;
                if (!renderer.isErrorImage) {
                    node.downloadImage = renderer.image;
                    node.errorImage = nil;
                    
                    if (node.downloadImage.images.count) {
                        return nil;
                    }
                    
                } else {
                    node.downloadImage = nil;
                    node.errorImage = renderer.image;
                    
                    if (node.errorImage.images.count) {
                        return nil;
                    }
                }
                
            }
        }
    } else {
        NSArray *images = renderer.image.images;
        NSTimeInterval duration = renderer.image.duration;
        
        if (images.count && duration) {
            //gif 图片 需要用view来处理
            return nil;
        }
    }
    
    return renderer;
}



+(void)setRenderer:(VZFRenderer *)renderer specs:(const NodeSpecs&)vs{
    renderer.backgroundColor = vs.backgroundColor;
    renderer.borderWidth = vs.borderWidth;
    renderer.borderColor = vs.borderColor;
    
    CGFloat cornerRadiusTopLeft = !FlexIsUndefined(vs.cornerRadiusTopLeft.value) ? vs.cornerRadiusTopLeft.value : vs.cornerRadius;
    CGFloat cornerRadiusTopRight = !FlexIsUndefined(vs.cornerRadiusTopRight.value) ? vs.cornerRadiusTopRight.value : vs.cornerRadius;
    CGFloat cornerRadiusBottomLeft = !FlexIsUndefined(vs.cornerRadiusBottomLeft.value) ? vs.cornerRadiusBottomLeft.value : vs.cornerRadius;
    CGFloat cornerRadiusBottomRight = !FlexIsUndefined(vs.cornerRadiusBottomRight.value) ? vs.cornerRadiusBottomRight.value : vs.cornerRadius;
    renderer.customCorner = {cornerRadiusTopLeft, cornerRadiusTopRight, cornerRadiusBottomLeft, cornerRadiusBottomRight};
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

//获取clip为YES并且不能被光栅化的nodes
+ (NSSet<VZFNode *> *)getClipAndCannotBeRasterizedNodes:(NodeLayout)rootLayout {
    NSMutableSet *resultNodes = [NSMutableSet set];
    
    //深度优先遍历rootLayout对应node tree
    /*
     * 定义虚"根",指根结点或者clip为YES并且存在结点的结点
     * 显然，一棵树中存在多个这样的虚"根"
     * 深度优先遍历，并且优先遍历子孙再遍历当前结点，即从下往上遍历树，检测所有的虚”根“是否能够被光栅化
     * 一个虚”根“不能被光栅化，当存在这样的子孙结点：
     * 1.显示内容超过了自己的bounds
     * 2.这个子孙结点与虚”根“之间（包括这个子孙结点，但不包括虚”根“），存在至少一个结点不能被光栅化
     */
    
    struct CheckItem{
        const NodeLayout& layout;
        BOOL isVisited;
        CGRect clipBounds;       //虚"根"的bounds
        CGPoint baseOrigin;      //父结点相对虚”根“的偏移，结合clipBounds计算当前结点是否超过了虚根的bounds
        BOOL hasUnrasterizedSuper; //从“根”到自己之间是否存在不能光栅化的结点，不包括“根”,不包括自己
        __weak VZFLayoutCheckResult *superCheckResult;        //super node传进来的，把检测结果保存在这里,相当于发挥结果
        __strong VZFLayoutCheckResult *selfCheckResult; //这个是自己的，深度优先遍历自己点，这里保存的子节点遍历后返回的结果
    };
    
    std::stack<CheckItem> stack = {};
    stack.push({rootLayout, NO, {CGPointZero, rootLayout.size}, CGPointZero, NO, nil, [[VZFLayoutCheckResult alloc] init]});
    while (!stack.empty()) {
        CheckItem& item = stack.top();
        const NodeLayout& layout = item.layout;
        VZFNode* node = layout.node;
        
        if (item.isVisited) {//子孙结点已经被访问过了
            
            VZFLayoutCheckResult *superResult = item.superCheckResult; //相当于返回结果，返回给父节点使用
            VZFLayoutCheckResult *selfResult = item.selfCheckResult; //保存了自己的信息，和子节点返回的信息
            
            if (layout.children->size() > 0) {
                //如果一个clip的结点没有子节点，那么他是否能光栅化，完全由[self canBeRasterized:node]决定，不用额外的判断
                if (layout.node.specs.clip) {
                    //对于clip的结点,selfResult.hasOutOfBoundsChildren不影响superResult.hasOutOfBoundsChildren，因为子的内容都被clip了
                    if (selfResult.hasOutOfBoundsChildren
                        && node) {
                        [resultNodes addObject:node];
                        selfResult.selfCanBeRasterized = NO; //当前结点不能被光栅化
                    }
                } else {
                    superResult.hasOutOfBoundsChildren |= selfResult.hasOutOfBoundsChildren;
                }
            }
            
            
            if (!superResult.hasOutOfBoundsChildren) {
                //再检测自己是否有超过
                CGRect frame = {layout.origin, layout.size};
                frame.origin.x += item.baseOrigin.x;
                frame.origin.y += item.baseOrigin.y;
                //判断自己是否超过了“根”的bounds，并且在自己和根之间是否有结点不能被光栅化（不包括“根”，包括自己）
                superResult.hasOutOfBoundsChildren |= !CGRectContainsRect(item.clipBounds, frame) && (item.hasUnrasterizedSuper || !selfResult.selfCanBeRasterized);
            }
            
            stack.pop();
        } else {
            item.isVisited = YES;
            
            BOOL canBeRasterized = [self canBeRasterized:node];
            
            if (item.superCheckResult) {
                //父类如果有一个子节点不能被光栅化，那么从这个子节点往后都不能被光栅化
                item.selfCheckResult.selfCanBeRasterized = canBeRasterized && !item.superCheckResult.childrenCannotBeRasterized;
                
                if (!item.superCheckResult.childrenCannotBeRasterized) {
                    item.superCheckResult.childrenCannotBeRasterized = !canBeRasterized;
                }
            } else {
                item.selfCheckResult.selfCanBeRasterized = canBeRasterized;
            }
            
            if (layout.children->size() > 0) {
                BOOL hasUnrasterizedSuper = NO;
                CGPoint baseOrigin = item.baseOrigin;
                CGRect clipBounds = item.clipBounds;
                
                if (node.specs.clip) {
                    baseOrigin = CGPointZero;
                    clipBounds = {CGPointZero, layout.size};
                    //clip为YES的结点作为一个新的“根”，因为hasUnrasterizedSuper不包括“根”，所以hasUnrasterizedSuper一定为NO，
                    hasUnrasterizedSuper = NO;
                } else {
                    baseOrigin.x += layout.origin.x;
                    baseOrigin.y += layout.origin.y;
                    hasUnrasterizedSuper = item.hasUnrasterizedSuper || !canBeRasterized;
                }
                
                for(auto reverseItor = layout.children->rbegin(); reverseItor != layout.children->rend(); reverseItor ++){
                    stack.push({*reverseItor, NO, clipBounds, baseOrigin, hasUnrasterizedSuper, item.selfCheckResult, [[VZFLayoutCheckResult alloc] init]});
                }
            }
        }
    }
    
    return [resultNodes copy];
}

@end

