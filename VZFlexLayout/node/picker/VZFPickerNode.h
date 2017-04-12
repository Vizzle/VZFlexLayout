//
//  VZFPickerNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFPickerNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class PickerNodeSpecs;
}

using namespace VZ;

@interface VZFPickerNode : VZFNode

@property (nonatomic, assign, readonly) PickerNodeSpecs pickerSpecs;

+ (instancetype)newWithPickerAttributes:(const PickerNodeSpecs&)pickerSpecs
                              NodeSpecs:(const NodeSpecs&)nodeSpecs;

@end
