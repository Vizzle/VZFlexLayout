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
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"

@class VZFlexNode;
@class VZFNodeController;
@class VZFNodeHostingView;

@interface VZFNode()

/**
 *  Node对应到UIKit的类型
 */
@property(nonatomic,assign,readonly)ViewClass viewClass;
/**
 *  Node的描述文件
 */
@property(nonatomic,assign,readonly)NodeSpecs specs;

/**
 *  内部引用的Objective-C类型的node
 */
@property(nonatomic,strong,readonly)VZFlexNode* flexNode;

/**
 *  父node
 */
@property(nonatomic,weak,readonly)VZFNode* parentNode;

@property(nonatomic,weak)VZFNodeHostingView* hostingView;

/**
 *  Node的初始状态
 *
 *  @return state
 */
+ (id)initialState;

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


@interface VZFNode(Tree)

- (void)addToParentNode:(VZFNode* )parentNode;

@end

@interface VZFNode(State)

- (id)responderForSelector:(SEL)selector;

- (VZFNodeController* )controller;

@end
#endif /* VZFNodeInternal_h */
