//
//  VZFSegmentControlNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/15.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFSegmentedControlNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class SegmentedControlNodeSpecs;
}

using namespace VZ;

@interface VZFSegmentedControlNode : VZFNode

@property (nonatomic, assign, readonly) SegmentedControlNodeSpecs segmentedControlSpecs;

+ (instancetype)newWithSegmentedControlAttributes:(const SegmentedControlNodeSpecs &)segmentedControlSpecs
                                        NodeSpecs:(const NodeSpecs &)nodeSpecs;


@end
