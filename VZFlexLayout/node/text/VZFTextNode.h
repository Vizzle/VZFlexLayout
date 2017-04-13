//
//  VZFTextNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFTextNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class TextNodeSpecs;
}
using namespace VZ;

@class VZFTextNodeRenderer;

@interface VZFTextNode : VZFNode

@property(nonatomic,assign,readonly) TextNodeSpecs textSpecs;
+ (instancetype)newWithTextAttributes:(const TextNodeSpecs&) textSpecs NodeSpecs:(const NodeSpecs&) specs;

@end
