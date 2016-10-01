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


@end



