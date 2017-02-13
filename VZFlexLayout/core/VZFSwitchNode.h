//
//  VZFSwitchNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFSwitchNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class SwitchNodeSpecs;
}

using namespace VZ;


@interface VZFSwitchNode : VZFNode

@property (nonatomic, assign, readonly) SwitchNodeSpecs switchSpecs;

+ (instancetype)newWithSwitchAttributes:(const SwitchNodeSpecs&)switchSpecs
                              NodeSpecs:(const NodeSpecs &)specs;

@end
