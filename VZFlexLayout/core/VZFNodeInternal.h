//
//  VZFNodeInternal.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#ifndef VZFNodeInternal_h
#define VZFNodeInternal_h

#import <UIKit/UIKit.h>
#import "VZFNode.h"
#import "VZFNodeLifeCycle.h"




/**
 *  前项声明
 */
namespace VZ {
    class NodeLayout;
    class ViewClass;
    class NodeSpecs;
    namespace UIKit{
        class MountContext;
        class MountResult;
    }
}

using namespace VZ;

@class VZFlexNode;
@class VZFNodeHostingView;

@interface VZFNode()

/**
 *  声明周期状态
 */
@property(nonatomic,assign,readonly)VZFNodeLifeCycleState state;
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
 *  node的父节点
 */
@property(nonatomic,weak)VZFNode* superNode;
/**
 *  计算Node的layout
 *
 *  @param sz
 *
 *  @return
 */
- (NodeLayout)computeLayoutThatFits:(CGSize)sz;

@end

@interface VZFNode(Layout)

//- (BOOL)shouldMemoizeLayout;

- (NodeLayout)nodeDidLayout;

@end


@interface VZFNode(ResponderChain)
/**
 *  response响应事件的方法
 *
 *  @param action 事件名
 *  @param sender sender
 *
 *  @return object
 */
- (id)targetForAction:(SEL)action withSender:(id)sender;

@end


@interface VZFNode(Mounting)
/**
 *  加载一个Node
 *
 *  @param size       node的size
 *  @param parentNode 父节点
 *
 *  @return 加载结果
 */
- (VZ::UIKit::MountResult)renderInContext:(const VZ::UIKit::MountContext &)context
                                   Size:(CGSize) size
                             ParentNode:(VZFNode* )parentNode;

//这个不会光栅化
- (VZ::UIKit::MountResult)mountInContext:(const VZ::UIKit::MountContext &)context
                                    Size:(CGSize) size
                              ParentNode:(VZFNode* )parentNode;

- (void)unmount;






@end


#endif /* VZFNodeInternal_h */
