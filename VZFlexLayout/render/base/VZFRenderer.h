//
//  VZFRenderer.h
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZFRenderer : NSObject

@property(nonatomic,strong) UIColor *backgroundColor;

@property(nonatomic,assign) CGFloat cornerRadius;

@property(nonatomic,assign) CGFloat borderWidth;
@property(nonatomic,strong) UIColor *borderColor;

@property(nonatomic,assign) BOOL clip;

//can not override by sub class
- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds;


@end


//for sub class to override
@interface VZFRenderer(foroverride)

- (void)drawContentInContext:(CGContextRef)context bounds:(CGRect)bounds;

@end
