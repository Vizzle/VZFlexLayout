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
#import "VZFNodeMountContext.h"
#import <stack>

using namespace VZ;
using namespace VZ::UIKit;
@implementation VZFNodeLayoutManager{

    dispatch_queue_t _layoutSerialQueue;
}

+ (instancetype)sharedInstance{

    static VZFNodeLayoutManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VZFNodeLayoutManager new];
    });
    return instance;
}


static const char* g_layoutQueueId = "com.React.layout.queue";
- (instancetype)init{
    
    self = [super init];

    if (self) {
        _layoutSerialQueue = dispatch_queue_create(g_layoutQueueId, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (NSSet<VZFNode* >* )layoutRootNode:(const NodeLayout& )layout InContainer:(UIView* )container WithPreviousNodes:(NSSet<VZFNode* >* )previousNodes AndSuperNode:(VZFNode* )superNode{

    //0, 计算出Root Node的layout
//    VZFNodeLayout layout = [rootNode computeLayoutThatFits:sz];
    
    struct MountItem{
        const NodeLayout& layout;
        MountContext context;
        VZFNode* superNode; 
        BOOL isVisited;
    };
    
    
    //1, 绑定root hosting view
    layout.node.rootNodeView = container;
    
    //保存mount出来的nodes
    NSMutableSet* mountedNodes = [NSMutableSet set];
    
    //2.1, 创建rootContext
    MountContext rootContext = MountContext::RootContext(container);
    //rootContext.position = layout.origin;

    //2.2, 创建一个stack用来递归
    std::stack<MountItem> stack = {};
    stack.push({layout,rootContext,superNode,NO});
  
    //2.3, 每个节点深度优先遍历
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
            
            //加载node，创建backing view
            MountResult mountResult = [item.layout.node mountInContext:item.context
                                                                  Size:item.layout.size
                                                            ParentNode:item.superNode];
            [mountedNodes addObject:item.layout.node];
            
            NSLog(@"<Mounted:%@ -> %@>",item.layout.node.class,item.layout.node.superNode.class);
        
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
                        mountResult.childContext.parentOffset((*reverseItor).origin, item.layout.size),
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
        [self unmountNodes:nodesToUnmount];
    }

    return  mountedNodes;

}

- (void)unmountNodes:(NSSet<VZFNode* >* )nodes{

    for(VZFNode* node in nodes){
        [node unmount];
    }
}

@end
