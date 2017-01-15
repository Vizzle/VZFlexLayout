//
//  VZFTextFieldNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFTextFieldNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class TextFieldNodeSpecs;
}

using namespace VZ;

@interface VZFTextFieldNode : VZFNode

@property (nonatomic, assign, readonly) TextFieldNodeSpecs textFieldSpecs;

+ (instancetype)newWithTextFieldAttributes:(const TextFieldNodeSpecs&)textFieldSpecs
                                 NodeSpecs:(const NodeSpecs&)specs;

@end
