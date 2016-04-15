//
//  VZFLineNode.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFLineNode.h"
#import "VZFMacros.h"
#import "VZFNodeSpecs.h"

@implementation VZFLineNode

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)lineNode {
    return [self lineNodeWithColor:[UIColor colorWithWhite:0xDD/255.f alpha:1]];
}

+ (instancetype)lineNodeWithColor:(UIColor *)color {
    return [self lineNodeWithColor:color thickness:1/[UIScreen mainScreen].scale];
}

+ (instancetype)lineNodeWithColor:(UIColor *)color thickness:(CGFloat)thickness {
    return [self lineNodeWithColor:color thickness:thickness margin:UIEdgeInsetsZero];
}

+ (instancetype)lineNodeWithColor:(UIColor *)color thickness:(CGFloat)thickness margin:(UIEdgeInsets)margin {
    NSAssert(thickness != VZ::FlexValue::Auto, @"thickness can't be auto");
    
    return [super newWithView:[UIView class] NodeSpecs:{
        .view = {
            .backgroundColor = color,
        },
        .flex = {
            .flexShrink = 0,
            .flexBasis = vzf_dim(thickness),
            .alignSelf = VZFlexStretch,
            .marginLeft = vzf_dim(margin.left),
            .marginTop = vzf_dim(margin.top),
            .marginRight = vzf_dim(margin.right),
            .marginBottom = vzf_dim(margin.bottom),
        }
    }];
}

@end
