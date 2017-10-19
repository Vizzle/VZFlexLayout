//
//  VZFNodeLayoutManager.h
//  O2OReact
//
//  Created by moxin on 16/3/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeLayout.h"

@class VZFNode;

//使用C API减少 Runtime Overhead
//所有方法MainThread - Only
namespace VZ {
    
    /**
     *  从根节点layout一棵Node树，将结果保存到NSSet<VZFNode* >中
     *
     *  @param layout        根节点的layout描述,@discussion：layout会产生copy
     *  @param container     根节点所在的容器
     *  @param previousNodes 之前保存下来的，layout完的node，传进来是用来比较
     *  @param superNode     根节点的父节点，通常为nil
     *  @discussion          MainThread - Only
     *  @return layout的结果
     */
    NSSet<VZFNode*>* layoutRootNodeInContainer(NodeLayout layout, UIView* container, NSSet<VZFNode* >* previousNodes, VZFNode* superNode);
    NSSet<VZFNode*>* layoutRootNodeInContainer(NodeLayout layout, UIView* container, NSSet<VZFNode* >* previousNodes, VZFNode* superNode, BOOL rasterizeUseCache, BOOL isUpdating);
    
    /**
     *  从根节点layout一颗树，并返回RootNode的container view
     *
     *  @param layout 根节点layout的描述
     *  @param sz     constraind size -> @example: CGSize{VZ::FlexValue::Auto(), VZ::FlexValue::Auto()}
     *  @discussion   MainThread - Only
     *  @return container view
     */
    UIView* viewForRootNode(NodeLayout layout, CGSize constrainedSize);
    
    /**
     *
     *  释放node加载出来的view
     *  @param nodes
     */
    void unmountNodes(NSSet<VZFNode* >* nodes);
    
}




