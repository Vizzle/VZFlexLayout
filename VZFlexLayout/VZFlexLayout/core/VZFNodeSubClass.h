//
//  VZFNodeSubClass.h
//  O2OReact
//
//  Created by moxin on 16/4/21.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNode.h"
#import "VZFStateUpdateMode.h"
#import "VZFluxAction.h"

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

/**
 *  Node的初始状态
 *
 *  @return state
 */
+ (id)initialState;
/**
 *  计算Node的layout
 *
 *  @param sz
 *
 *  @return void
 */
- (NodeLayout)computeLayoutThatFits:(CGSize)sz;

/**
 *  更新状态，(old) -> (new)
 *
 *  @param updateBlock
 */
- (void)updateState:(id(^)(id))updateBlock Mode:(VZFActionUpdateMode)mode;

/**
 *  dispatch action
 *
 *  @param mode
 */
- (void)dispatch:(const VZ::FluxAction&)action Mode:(VZFActionUpdateMode)mode;

/**
 *  是否需要缓存计算过的layout
 *
 *  @return true/false
 */
- (BOOL)shouldMemoizeLayout;

/**
 *  自定义node需要override这个方法
 *
 *  @return layout
 */
- (NodeLayout)nodeDidLayout NS_REQUIRES_SUPER;
/**
 *  返回controller的下一个responder
 *
 *  @return object
 */
- (id)nextResponderAfterController;
/**
 *  response响应事件的方法
 *
 *  @param action 事件名
 *  @param sender sender
 *
 *  @return object
 */
- (id)targetForAction:(SEL)action withSender:(id)sender;
/**
 *  node mount view之前调用
 */
-(void)willMount NS_REQUIRES_SUPER;

/**
 *  node mount view之后调用
 */
-(void)didMount NS_REQUIRES_SUPER ;


@end
