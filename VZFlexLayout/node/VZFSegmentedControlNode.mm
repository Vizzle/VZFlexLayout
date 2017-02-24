//
//  VZFSegmentControlNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/15.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFSegmentedControlNode.h"
#import "VZFSegmentedControl.h"

@implementation VZFSegmentedControlNode

+ (instancetype)newWithSegmentedControlAttributes:(const VZ::SegmentedControlNodeSpecs &)segmentControlSpecs
                                        NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs {
    VZFSegmentedControlNode *node = [super newWithView:[VZFSegmentedControl class] NodeSpecs:nodeSpecs];
    if (node) {
        node -> _segmentedControlSpecs = segmentControlSpecs;
    }
    return node;
}

@end
