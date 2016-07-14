//
//  VZFNodeSubClass.h
//  O2OReact
//
//  Created by moxin on 16/4/21.
//  Copyright © 2016年 Alipay. All rights reserved.
//

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

@interface VZFNode()

/**
 *  返回node关联的view
 */
@property(nonatomic,weak)UIView* mountedView;
@property(nonatomic,strong,readonly) VZFNode* rootNode;
@property(nonatomic,weak)UIView* rootView;
/**
 *  计算Node的layout
 *
 *  @param sz
 *
 *  @return void
 */
- (NodeLayout)computeLayoutThatFits:(CGSize)sz;
/**
 *  自定义node需要override这个方法
 *
 *  @return layout
 */
- (NodeLayout)nodeDidLayout NS_REQUIRES_SUPER;
/**
 *  nextResponder of Node
 *
 *  1, Node's controller
 *  2, Node's parent node
 *  3, Hosting view if this node is the root node
 *
 */
- (id)nextResponder;
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



