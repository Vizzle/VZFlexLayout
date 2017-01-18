//
//  VZFImageNodeRenderer.m
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFImageNodeRenderer.h"

@implementation VZFImageNodeRenderer

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds {
    if (self.image == nil) {
        return;
    }
    
    CGRect rect = [[self class] getDrawRect:bounds imageSize:self.image.size contentMode:self.contentMode scale:self.scale <= 0 ? 1 : self.scale];
    
    CGContextDrawImage(context, rect, self.image.CGImage);

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
    
    return drawRect4Point;
}


@end
