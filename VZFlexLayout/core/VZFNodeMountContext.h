//
//  VZFNodeMountContext.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFNodeViewManager.h"
#import "VZFRenderer.h"

namespace VZ
{
    namespace UIKit
    {
        /**
         *  Node在mount过程中缓存的数据
         */
        struct MountContext{
            
            //类方法
            static MountContext RootContext(UIView* v){
        
                return MountContext([[VZFNodeViewManager alloc]initWithView:v shouldAutoReset:YES],{0,0});
                
            };
            
            //每个context关联一个view manager
            __strong VZFNodeViewManager* viewManager;
//            std::shared_ptr<VZFNodeViewManager> viewManager;
            
            //view manager关联view的原点，子view根据这个点计算位置
            CGPoint position;
            
            //view据root view的边距
            UIEdgeInsets rootLayoutInsect;
            
            /**
             *  相对根节点的位置
             */
            MountContext rootOffset(const CGPoint p, const CGSize parentSize) const{
                
                //const UIEdgeInsets rootLayout = transformToRootLayout(rootLayoutInsect,p,parentSize,childSize);
                return MountContext(viewManager,position + p);
            };
            /**
             *  相对父节点的位置
             */
            MountContext parentOffset(const CGPoint p, const CGSize parentSize) const{
            
                return MountContext(viewManager,p);
            }
            
            /**
             *  @param subview
             *  @param isCorrespondingView 传入subview是否是当前node所对应的node，如果是，会在合适的时机负责对该view进行reset
             */
            MountContext childContextForSubview(UIView *subview, BOOL isCorrespondingView) const {
                return MountContext([[ VZFNodeViewManager alloc ] initWithView:subview shouldAutoReset:isCorrespondingView parentManager:viewManager] , {0,0});
            };
            
            
            ~MountContext(){ viewManager = nil; }
            
        private:
            
            MountContext(VZFNodeViewManager* m, const CGPoint p)
            : viewManager(m), position(p){}
            
            /**
             *  将自己的坐标transform为root node的坐标
             *
             *  @param parentLayoutInsect 父容器edgeInsects
             *  @param offset             自己相对于父容器的offset
             *  @param parentSize         父容器的大小
             *  @param childSize          自己的大小
             *
             *  @return 自己相对于root容器的大小
             */
            static UIEdgeInsets transformToRootLayout(const UIEdgeInsets parentLayoutInsect,
                                                      const CGPoint offset,
                                                      const CGSize parentSize,
                                                      const CGSize childSize){
                return {
                    .left   = parentLayoutInsect.left + offset.x,
                    .top    = parentLayoutInsect.top + offset.y,
                    .right  = parentLayoutInsect.right + (parentSize.width - childSize.width) - offset.x,
                    .bottom = parentLayoutInsect.bottom + (parentSize.height - childSize.height) - offset.y,
                };
            };
            
        };
        
        
        struct MountResult{
            
            BOOL hasChildren;
            VZ::UIKit::MountContext childContext;
        };
    }
}

typedef VZ::UIKit::MountResult VZFMountResult;
