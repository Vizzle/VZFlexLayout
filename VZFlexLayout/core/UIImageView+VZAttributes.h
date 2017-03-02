//
//  UIImageView+VZAttributes.h
//  Pods
//
//  Created by heling on 2017/3/1.
//
//

#import <UIKit/UIKit.h>
@class VZFNode;

@interface UIImageView (VZAttributes)

/**
 应用imagenode的各种属性，保持和  UIView+VZAttributes 一致
 @param node node
 */

- (void)vz_applyNodeAttributes:(VZFNode *)node;

@end
