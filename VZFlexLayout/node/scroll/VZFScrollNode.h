//
//  VZFScrollNode.h
//  O2OReact
//
//  Created by moxin on 16/5/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <vector>
#import "VZFNode.h"
#import "VZFScrollNodeSpecs.h"
#import "VZFStackNodeSpecs.h"
#import "VZFNodeBackingViewInterface.h"

using namespace VZ;
@interface VZFScrollNode : VZFNode

@property(nonatomic,assign,readonly)ScrollNodeSpecs scrollNodeSpecs;
@property(nonatomic,assign,readonly)StackNodeSpecs stackNodeSpecs;
@property(nonatomic,assign,readonly)std::vector<VZFNode*> children;
@property(nonatomic,assign,readonly)CGSize contentSize;

+ (instancetype)newWithScrollAttributes:(const ScrollNodeSpecs &)scrollSpecs
                        StackAttributes:(const StackNodeSpecs &)stackSpecs
                              NodeSpecs:(const NodeSpecs &)nodeSpecs
                               Children:(std::vector<VZFNode*>)children;

+ (instancetype)newWithScrollAttributes:(const ScrollNodeSpecs &)scrollSpecs
                        StackAttributes:(const StackNodeSpecs &)stackSpecs
                              NodeSpecs:(const NodeSpecs &)nodeSpecs
                       BackingViewClass:(Class<VZFNodeBackingViewInterface>)backingViewClass
                               Children:(std::vector<VZFNode*>)children;

@end
