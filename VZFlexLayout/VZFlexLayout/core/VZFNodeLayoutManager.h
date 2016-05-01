//
//  VZFNodeLayoutManager.h
//  O2OReact
//
//  Created by moxin on 16/3/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace VZ {
    class NodeLayout;
}
using namespace VZ;

@class VZFNode;
@interface VZFNodeLayoutManager : NSObject

+ (instancetype)sharedInstance;



/**
 *  从根节点layout一棵Node树，将结果保存到NSSet<VZFNode* >中
 *
 *  @param layout        根节点的layout描述
 *  @param container     根节点所在的容器
 *  @param previousNodes 之前保存下来的，layout完的node，传进来是用来比较
 *  @param superNode     根节点的父节点，通常为nil
 *
 *  @return layout的结果
 */
- (NSSet<VZFNode*>* )layoutRootNode:(const NodeLayout& )layout
                        InContainer:(UIView* )container
                  WithPreviousNodes:(NSSet<VZFNode* >* )previousNodes
                       AndSuperNode:(VZFNode* )superNode;

/**
 *  从根节点layout一颗树，并返回最终的view
 *
 *  @param layout 根节点layout的描述
 *  @param sz     constraind size -> @example: CGSize{VZ::FlexValue::Auto, VZ::FlexValue::Auto}
 *
 *  @return container view
 */
- (UIView* )viewForRootNode:(const NodeLayout& )layout ConstrainedSize:(CGSize)sz;
/**
 *
 *
 *  @param nodes
 */
- (void)unmountNodes:(NSSet<VZFNode* >* )nodes;

@end
