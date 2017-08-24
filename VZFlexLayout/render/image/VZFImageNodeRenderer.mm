//
//  VZFImageNodeRenderer.m
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFImageNodeRenderer.h"
#import "VZFImageNode.h"
#import "VZFNodeListItemRecycler.h"
#import "VZFNodeInternal.h"

#import "VZFImageNodeSpecs.h"

@implementation VZFImageNodeRenderer

//图片下载成功回调
- (void)invoke:(id)sender withCustomParam:(NSDictionary *)imageDic{
    
    //同步调进来的时候self.node没有
    UIImage *errorImage = [imageDic objectForKey:@"errorImage"];
    UIImage *image = [imageDic objectForKey:@"image"];
    
    if (!self.node && imageDic && (image || errorImage)) {
        //同步调进来的时候self.node为空
        self.image = image;
        self.downloadImageUrl = imageDic[@"url"];
        if (!self.image && errorImage) {
            self.image = errorImage;
            self.isErrorImage = YES;
        } else {
            self.isErrorImage = NO;
        }
    } else if ([self.node isKindOfClass:[VZFImageNode class]] && imageDic && (image || errorImage)){
        //异步调进来
        VZFImageNode *imageNode = (VZFImageNode *)self.node;
        imageNode.downloadImage =  image;
        imageNode.errorImage = errorImage;
        imageNode.downloadImageUrl = imageDic[@"url"];
        
        self.downloadImageUrl = imageDic[@"url"];
        self.image = image;
        if (!self.image && errorImage) {
            self.isErrorImage = YES;
            self.image = errorImage;
        } else {
            self.isErrorImage = NO;
        }
        
        VZFRenderer *render = self;
        while (render.superRenderer) {
            render = render.superRenderer;
        }
        UIView *v = [render.node mountedView];
        if(v){
            UIView *superview = v;
            while (!superview.vz_recycler && superview.superview) {
                superview = superview.superview;
            }
     
            VZFNodeListItemRecycler *recyler = superview.vz_recycler;
            if (recyler) {
                VZFDispatchMain(0, ^{
                    [recyler attachToView:superview];
                });
            } else {
                [v.layer setNeedsDisplay];
            }
            
        }else{
            
        }
    }
    
    if (self.completion) {
        VZFDispatchMain(0, ^{
            [self.completion invoke:sender withCustomParam:imageDic];
        });
    } else if ([self.node isKindOfClass:[VZFImageNode class]]) {
        VZFBlockAction *completion = [(VZFImageNode *)self.node imageSpecs].completion;
        if (completion) {
            VZFDispatchMain(0, ^{
                [completion invoke:sender withCustomParam:imageDic];
            });
        }
    }
}

- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds {
    if (self.image == nil) {
        return;
    }

    CGContextSaveGState(context);
    
    CGContextBeginPath(context);
    CGContextAddRect(context, bounds);
    CGContextClip(context);
    
    CGFloat scale = self.scale <= 0 ? 1 : self.scale;
    
    CGRect rect = [[self class] getDrawRect:bounds imageSize:self.image.size contentMode:self.contentMode scale:scale];

    [self.image drawInRect:rect];
    
    CGContextRestoreGState(context);
}



+(CGRect)getDrawRect:(CGRect)bound imageSize:(CGSize)imageSize contentMode:(UIViewContentMode)contentMode scale:(CGFloat)scale{
    //图片绘制区域
    CGRect drawRect4Point = bound;
    //拉伸最长边 展示全图
    //     ------   *******************
    //    |      |  */////////////////*
    //    |      |  */////////////////*
    //    |  图  |   *////绘制区域/////*
    //    |      |  */////////////////*
    //    |      |  */////////////////*
    //     ------   *******************
    
    if (contentMode== UIViewContentModeScaleAspectFit) {
        if (imageSize.width/imageSize.height<bound.size.width/bound.size.height) {
            //            ***********------***********
            //            */////////|      |/////////*
            //            */////////|      |/////////*
            //            */////////|      |/////////*
            //            */////////|      |/////////*
            //            */////////|      |/////////*
            //            */////////|      |/////////*
            //            ***********------***********
            CGFloat w4Point = imageSize.width*bound.size.height/imageSize.height;
            drawRect4Point.origin = CGPointMake(MAX(0, floor((bound.size.width-w4Point)*scale/2))/scale, 0);
            drawRect4Point.size = CGSizeMake(bound.size.width-2*drawRect4Point.origin.x,bound.size.height);
        }else{
            //            ****************************
            //            *//////////////////////////*
            //            *--------------------------*
            //            |                          |
            //            |                          |
            //            |                          |
            //            *--------------------------*
            //            *//////////////////////////*
            //            ****************************
            CGFloat h4Point = imageSize.height*bound.size.width/imageSize.width;
            drawRect4Point.origin = CGPointMake(0,MAX(0, floor((bound.size.height-h4Point)*scale/2))/scale);
            drawRect4Point.size = CGSizeMake(bound.size.width,bound.size.height-2*drawRect4Point.origin.y);
        }
    }
    //拉伸最端边 撑满view 截取部分image
    else if(contentMode == UIViewContentModeScaleAspectFill){
        if (imageSize.width/imageSize.height<bound.size.width/bound.size.height) {
            //            -------------
            //            |           |
            //            |           |
            //            |           |
            //            *************
            //            *           *
            //            *           *
            //            *           *
            //            *************
            //            |           |
            //            |           |
            //            |           |
            //            -------------
            CGFloat h4Point = imageSize.height*bound.size.width/imageSize.width;
            drawRect4Point.origin = CGPointMake(0,MIN(0, floor((bound.size.height-h4Point)*scale/2))/scale);
            drawRect4Point.size = CGSizeMake(bound.size.width,bound.size.height-2*drawRect4Point.origin.y);
        }else{
            CGFloat w4Point = imageSize.width*bound.size.height/imageSize.height;
            drawRect4Point.origin = CGPointMake(MIN(0, floor((bound.size.width-w4Point)*scale/2))/scale, 0);
            drawRect4Point.size = CGSizeMake(bound.size.width-2*drawRect4Point.origin.x,bound.size.height);
        }
    }else if (contentMode == UIViewContentModeBottom){
        drawRect4Point.origin = CGPointMake( (bound.size.width-imageSize.width)/2 , bound.size.height-imageSize.height);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeBottomLeft){
        drawRect4Point.origin = CGPointMake( 0 , bound.size.height-imageSize.height);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeBottomRight){
        drawRect4Point.origin = CGPointMake( bound.size.width-imageSize.width , bound.size.height-imageSize.height);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeTop){
        drawRect4Point.origin = CGPointMake( bound.size.width-imageSize.width , (bound.size.height-imageSize.height)/2);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeTopLeft){
        drawRect4Point.origin = CGPointMake( 0,0);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeTopRight){
        drawRect4Point.origin =  CGPointMake( bound.size.width-imageSize.width ,0);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeLeft){
        drawRect4Point.origin =  CGPointMake( 0 , (bound.size.height-imageSize.height)/2);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeRight){
        drawRect4Point.origin =  CGPointMake( bound.size.width-imageSize.width , (bound.size.height-imageSize.height)/2);
        drawRect4Point.size = imageSize;
    }else if(contentMode == UIViewContentModeCenter){
        drawRect4Point.origin =  CGPointMake( (bound.size.width-imageSize.width)/2 , (bound.size.height-imageSize.height)/2);
        drawRect4Point.size = imageSize;
    }
    
    drawRect4Point.origin = CGPointMake(drawRect4Point.origin.x + bound.origin.x, drawRect4Point.origin.y +bound.origin.y );
    return drawRect4Point;
}


@end
