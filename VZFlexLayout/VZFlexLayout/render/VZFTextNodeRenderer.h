//
//  VZFTextNodeRender.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFTextNodeSpecs.h"

using namespace VZ;
@interface VZFTextNodeRenderer : NSObject

@property(nonatomic,assign,readonly) TextNodeSpecs specs;

/**
 根据TextKit的描述创建Render

 @param specs Text属性描述
 @param size  文本layout大小

 */
- (instancetype)initWithTextKitSpecs:(const TextNodeSpecs& )specs constraintSize:(CGSize)size;

- (CGSize)textSize;

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds;

@end

