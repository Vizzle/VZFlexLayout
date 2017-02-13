//
//  VZFSwitchNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFSwitchNode.h"

@implementation VZFSwitchNode

+ (instancetype)newWithSwitchAttributes:(const VZ::SwitchNodeSpecs &)switchSpecs NodeSpecs:(const VZ::NodeSpecs &)specs {
    VZFSwitchNode *node = [super newWithView:[UISwitch class] NodeSpecs:specs];
    if (node) {
        node->_switchSpecs = switchSpecs.copy();
    }
    return node;
}

@end
