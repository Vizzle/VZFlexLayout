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

typedef struct {
    VZFNode *node;
}VZFScrollChildNode;

using namespace VZ;
@interface VZFScrollNode : VZFNode

@property(nonatomic,assign,readonly)ScrollNodeSpecs scrollNodeSpecs;
@property(nonatomic,assign,readonly)std::vector<VZFScrollChildNode> children;

+ (instancetype)newWithScrollAttributes:(const ScrollNodeSpecs &)scrollSpecs
                              NodeSpecs:(const NodeSpecs &)nodeSpecs
                               Children:(std::vector<VZFScrollChildNode>)children;

- (CGSize)contentSize;

@end
