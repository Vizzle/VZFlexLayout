//
//  VZFIndicatorNode.h
//  O2OReact
//
//  Created by Sleen on 16/6/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFNode.h"
#import "VZFIndicatorNode.h"

namespace VZ {
    class NodeSpecs;
    class IndicatorNodeSpecs;
}

@interface VZFIndicatorNode : VZFNode

@property(nonatomic,assign,readonly) VZ::IndicatorNodeSpecs indicatorSpecs;
+ newWithIndicatorAttributes:(const VZ::IndicatorNodeSpecs&)indicatorSpecs NodeSpecs:(const VZ::NodeSpecs&)specs;

@end
