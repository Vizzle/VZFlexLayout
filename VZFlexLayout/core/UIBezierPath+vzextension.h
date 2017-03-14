//
//  UIBezierPath+vzextension.h
//  VZFlexLayout
//
//  Created by pep on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (extension)

+ (UIBezierPath *)vz_roundRectPathWithWidth:(CGFloat)width
                                  height:(CGFloat)height
                           topLeftRadius:(CGFloat)topLeftRadius
                          topRightRadius:(CGFloat)topRightRadius
                        bottomLeftRadius:(CGFloat)bottomLeftRadius
                       bottomRightRadius:(CGFloat)bottomRightRadius;
@end
