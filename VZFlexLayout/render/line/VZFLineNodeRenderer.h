//
//  VZFLineNodeRenderer.h
//  O2OReact
//
//  Created by pep on 2017/10/3.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "VZFRenderer.h"

@interface VZFLineNodeRenderer : VZFRenderer

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGFloat dashLength;
@property (nonatomic) CGFloat spaceLength;

@end
