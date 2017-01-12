//
//  VZFTextNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"

using namespace VZ;
@class VZFTextNodeRenderer;

@interface VZFTextNode : VZFNode

@property(nonatomic,assign,readonly) TextNodeSpecs textSpecs;
@property(nonatomic,assign,readonly) VZFTextNodeRenderer *renderer;
+ (instancetype)newWithTextAttributes:(const TextNodeSpecs&) textSpecs NodeSpecs:(const NodeSpecs&) specs;

@end
