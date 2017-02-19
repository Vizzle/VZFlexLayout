//
//  UIView+VZAttributes.h
//  O2OReact
//
//  Created by moxin on 16/4/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VZFNode;

@interface UIView (VZAttributes)

/**
 *  应用view的各种属性
 */
- (void)applyAttributes;


/**
 应用node的各种属性，各node对应的view实现该方法以应用各自node的属性

 @param node node
 */
- (void)vz_applyNodeAttributes:(VZFNode *)node;

@end
