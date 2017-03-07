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
@implementation VZFImageNodeRenderer

//图片下载成功回调
- (void)invoke:(id)sender withCustomParam:(NSDictionary *)imageDic{
    
    if (!self.node && imageDic && imageDic[@"image"]) {
        self.image =  imageDic[@"image"];
        self.downloadImageUrl = imageDic[@"url"];
        return;
    }
    
    if([self.node isKindOfClass:[VZFImageNode class]] && imageDic && imageDic[@"image"]){
        VZFImageNode *imageNode = (VZFImageNode *)self.node;
        imageNode.downloadImage =  imageDic[@"image"];
        imageNode.downloadImageUrl = imageDic[@"url"];
        
        self.downloadImageUrl = imageDic[@"url"];
        self.image = imageDic[@"image"];
        
        VZFNode *node = self.node;
        VZFRenderer *render = self;
        while (render.superRenderer) {
            render = render.superRenderer;
        }
        UIView *v = [render.node mountedView];
        if(v){
            UIView *superview = v;
            while (!superview.vz_recycler || !superview.superview) {
                superview = superview.superview;
            }
            VZFNodeListItemRecycler *recyler = superview.vz_recycler;
            if (recyler) {
                VZFDispatchMain(0, ^{
                    [recyler attachToView:superview];
                });
                return;
            }
            
            [v.layer setNeedsDisplay];
        }else{
            
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
