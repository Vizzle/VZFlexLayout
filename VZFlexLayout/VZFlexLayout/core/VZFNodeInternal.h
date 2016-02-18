//
//  VZFNodeInternal.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#ifndef VZFNodeInternal_h
#define VZFNodeInternal_h

#import "VZFNode.h"
#import "VZFNodeLayout.h"

@class VZFlexNode;
@interface VZFNode()

@property(nonatomic,strong,readonly)VZFlexNode* flexNode;

/**
 *  更新状态，(old) -> (new)
 *
 *  @param updateBlock
 */
- (void)updateState:(id(^)(id))updateBlock;

/**
 *  计算Node的layout
 *
 *  @param sz
 *
 *  @return
 */
- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz;

@end
#endif /* VZFNodeInternal_h */
