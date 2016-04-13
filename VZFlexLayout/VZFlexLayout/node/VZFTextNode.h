//
//  VZFTextNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"

namespace VZ {
    class NodeSpecs;
    class TextNodeSpecs;
}
using namespace VZ;

@interface VZFTextNode : VZFNode

@property(nonatomic,assign,readonly) TextNodeSpecs textSpecs;
+ (instancetype)newWithNodeSpecs:(const NodeSpecs&) specs TextAttributes:(const TextNodeSpecs&) textSpecs;

@end
