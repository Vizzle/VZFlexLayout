//
//  VZFNodeLayoutManager.m
//  O2OReact
//
//  Created by moxin on 16/3/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFNodeLayoutManager.h"
#import "VZFUtils.h"
#import "VZFNodeLayout.h"
#import "VZFNodeInternal.h"
#import "VZFNodeLifeCycle.h"
#import "VZFNodeMountContext.h"
#import "VZFMacros.h"
#import <stack>
#import "VZFAsyncDrawingTransactionContainer.h"
#import "VZFRasterizeNodeTool.h"

using namespace VZ::UIKit;

namespace VZ {
    
    MountResult mountInContext(VZFNode *node, const VZ::UIKit::MountContext &context, CGSize size, VZFNode* parentNode, BOOL asyncDisplay, VZFRasterizeCachePolicy rasterizeCachePolicy, BOOL cannotBeRasterized) {
        if (asyncDisplay) {
            return [node renderInContext:context
                                    Size:size
                              ParentNode:parentNode
                      cannotBeRasterized:cannotBeRasterized
                    rasterizeCachePolicy:rasterizeCachePolicy];
        } else {
            return [node mountInContext:context
                                   Size:size
                             ParentNode:parentNode];
        }
        
    }
    
    NSSet<VZFNode*>* layoutRootNodeInContainer(NodeLayout layout, UIView* container, NSSet<VZFNode* >* previousNodes, VZFNode* superNode) {
        return layoutRootNodeInContainer(layout, container, previousNodes, superNode, NO);
    }
    
    NSSet<VZFNode*>* layoutRootNodeInContainer(NodeLayout layout, UIView* container, NSSet<VZFNode* >* previousNodes, VZFNode* superNode, BOOL rasterizeUseCache){
        //This method should be called on main thread
        VZFCAssertMainThread();

        VZFC_LOG_THREAD(@"LayoutManager",@"LayoutRootNode");
        
        //设置根节点layer 作为异步渲染的管理节点
        container.layer.isAsyncTransactionContainer = YES;
        
        NSSet<VZFNode *> *clipAndCannotBeRasterizedNodes = nil;
        
        if (layout.node.specs.asyncDisplay) {
            clipAndCannotBeRasterizedNodes = [VZFRasterizeNodeTool getClipAndCannotBeRasterizedNodes:layout];
        }
        
        //0, 计算出Root Node的layout
        struct MountItem{
            const NodeLayout& layout;
            MountContext context;
            VZFNode* superNode;
            BOOL isVisited;
        };
        
        //1, 绑定root hosting view
        //    layout.node.rootNodeView = container;
        
        //保存mount出来的nodes
        NSMutableSet* mountedNodes = [NSMutableSet set];
        
        //2.1, 创建rootContext
        MountContext rootContext = MountContext::RootContext(container);
        rootContext.position = layout.origin;
        
        //2.2, 创建一个stack用来递归
        std::stack<MountItem> stack = {};
        stack.push({layout,rootContext,superNode,NO});
        
        //2.3, 每个节点深度优先遍历
        /**
         * @discussion:
         * 这里从根节点开始遍历每一个子节点，会产生频繁的递归调用
         * 可以使用lambda表达式做函数式递归，但考虑这个过程很频繁，这里使用while+stack的递归方式，减少栈空间的频繁开销
         */
        while (!stack.empty()) {
            
            //这里面取引用，因为要改变它的状态
            MountItem& item = stack.top();
            if(item.isVisited){
                
                //@discussion:所有child mount完再通知
                [item.layout.node didMount];
                stack.pop();
                
            }
            else{
                
                //创建一个mark
                item.isVisited = YES;
                
                if(item.layout.node == nil){
                    continue;
                }
                
                //will mount
                [item.layout.node willMount];
                
                
                VZFNode *node = item.layout.node;
                
                BOOL asyncDisplay = node.specs.asyncDisplay;
                BOOL cannotBeRasterized = [clipAndCannotBeRasterizedNodes containsObject:node];
                
                VZFRasterizeCachePolicy cachePolicy = VZFRasterizeCachePolicyNode;
                
                if (asyncDisplay && rasterizeUseCache) {
                    cachePolicy |= VZFRasterizeCachePolicyLayer;
                }
                
                //加载node，创建backing view
                //这个方法必须在主线程调用
                MountResult mountResult = mountInContext(node, item.context, item.layout.size, item.superNode, asyncDisplay, cachePolicy, cannotBeRasterized);
                
                [mountedNodes addObject:item.layout.node];
                
                //VZFNSLog(@"<Mounted:%@ -> %@>",item.layout.node.class,item.layout.node.superNode.class);
                
                if (mountResult.hasChildren) {
                    
                    /**
                     *  @discussion：注意两点:
                     *
                     *  1, 理论上使用FlexNode layout出来的 node🌲和应该和FNode🌲严格一一对应
                     *
                     *  2, 使用反向迭代器，保证最底部的FNode先被mount
                     */
                    
                    for(auto reverseItor = item.layout.children->rbegin(); reverseItor != item.layout.children->rend(); reverseItor ++){
                        
                        stack.push(
                                   {*reverseItor,
//                                       mountResult.childContext.parentOffset((*reverseItor).origin, item.layout.size),
                                       mountResult.childContext.rootOffset((*reverseItor).origin, item.layout.size),
                                       item.layout.node,
                                       NO});
                    }
                }
                
            }
            
        }
        
        //3, unmount原来的nodes
        if(previousNodes){
            
            NSMutableSet* nodesToUnmount = [previousNodes mutableCopy];
            [nodesToUnmount minusSet:mountedNodes];
            unmountNodes(nodesToUnmount);
        }
        
        return  mountedNodes;
    }
    

    UIView* viewForRootNode(NodeLayout layout, CGSize sz){
      
        VZFCAssertMainThread();
        
        UIView* container = [[UIView alloc]initWithFrame:CGRect{{0,0},sz}];
        
        layoutRootNodeInContainer(layout, container, nil, nil);
        
        return container;
    }
    
    void unmountNodes(NSSet<VZFNode* >* nodes){
    
        VZFC_LOG_THREAD(@"LayoutManager",@"unmountNodes");
        
        //会有在非主线程unmount的情况,bounce到Main Thread
        VZFDispatchMain(0, ^{
//        VZF_MainCall(^{
            
            for(VZFNode* node in nodes){
                [node unmount];
            }
        });
    }
    
}
