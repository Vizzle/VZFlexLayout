//
//  VZFTextViewNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFTextViewNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class TextViewNodeSpecs;
}

using namespace VZ;

@interface VZFTextViewNode : VZFNode

@property (nonatomic, assign, readonly) TextViewNodeSpecs textViewNodeSpecs;

+ (instancetype)newWithTextViewAttributes:(const TextViewNodeSpecs &)textViewNodeSpecs
                                NodeSpecs:(const NodeSpecs &)nodeSpecs;

@end
