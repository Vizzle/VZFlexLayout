//
//  VZFTextNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFTextNodeSpecs.h"

@interface VZFTextNode : VZFNode

@property(nonatomic,assign,readonly) NodeSpecs specs;
@property(nonatomic,assign,readonly) TextNodeSpecs textSpecs;

+ (instancetype)newWithNodeSpecs:(const NodeSpecs&) specs TextAttributes:(const TextNodeSpecs&) textSpecs;

@end
