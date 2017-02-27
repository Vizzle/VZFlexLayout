//
//  VZFPickerNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFPickerNode.h"
#import "VZFPickerView.h"

@implementation VZFPickerNode

+ (instancetype)newWithPickerAttributes:(const VZ::PickerNodeSpecs &)pickerSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs {
    VZFPickerNode *node = [super newWithView:[VZFPickerView class] NodeSpecs:nodeSpecs];
    if (node) {
        node->_pickerSpecs = pickerSpecs.copy();
    }
    return node;
}

@end
