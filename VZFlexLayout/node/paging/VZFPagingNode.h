//
//  VZFPagingNode.h
//  O2OReact
//
//  Created by Sleen on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <vector>
#import "VZFNode.h"
#import "VZFPagingNodeSpecs.h"
#import "VZFNodeLayout.h"

using namespace VZ;
@interface VZFPagingNode : VZFNode

@property(nonatomic,assign,readonly)PagingNodeSpecs pagingNodeSpecs;
@property(nonatomic,assign,readonly)std::vector<VZFNode*> children;
@property(nonatomic,strong,readonly)VZFNode* pageControlNode;
@property(nonatomic,assign,readonly)std::vector<NodeLayout> childrenLayout;

@property(nonatomic,strong) NSArray<UIView*>* viewsCache;

+ (instancetype)newWithPagingAttributes:(const PagingNodeSpecs &)pagingSpecs
                              NodeSpecs:(const NodeSpecs &)nodeSpecs
                               Children:(std::vector<VZFNode*>)children;

@end
