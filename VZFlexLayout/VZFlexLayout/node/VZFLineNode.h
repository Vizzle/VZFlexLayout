//
//  VZFLineNode.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"

@interface VZFLineNode : VZFNode

+ (instancetype)lineNode;
+ (instancetype)lineNodeWithColor:(UIColor *)color;
+ (instancetype)lineNodeWithColor:(UIColor *)color thickness:(CGFloat)thickness;
+ (instancetype)lineNodeWithColor:(UIColor *)color thickness:(CGFloat)thickness margin:(UIEdgeInsets)margin;

@end
