//
//  VZFSwitchNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFSwitchNode.h"
#import "VZFSwitch.h"

@implementation VZFSwitchNode

+ (instancetype)newWithSwitchAttributes:(const VZ::SwitchNodeSpecs &)switchSpecs NodeSpecs:(const VZ::NodeSpecs &)specs {
    // UISwitch has a fix width & height
    NodeSpecs newSpecs = specs;
    newSpecs.width = 51;
    newSpecs.height = 31;
    VZFSwitchNode *node = [super newWithView:[VZFSwitch class] NodeSpecs:newSpecs];
    if (node) {
        node->_switchSpecs = switchSpecs.copy();
    }
    return node;
}

@end
