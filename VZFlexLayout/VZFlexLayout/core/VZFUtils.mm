//
//  VZFUtils.c
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <objc/runtime.h>
#import "VZFUtils.h"
#import "VZFMacros.h"
#import "VZFViewReuseInfo.h"
#import "VZFNodeViewClass.h"
#import "VZFStackNode.h"
#import "VZFCompositeNode.h"

namespace VZ{
    namespace Helper{
        std::string stringFromPointer(const void* ptr){
            char buf[64];
            snprintf(buf, sizeof(buf), "%p", ptr);
            return buf;
        }
    }

    
    namespace Mounting{
        
        
        const void* g_reuseId = &g_reuseId;
        void mountingRootView(UIView* v){
            
            
            if (!v) {
                return;
            }
            
            if (objc_getAssociatedObject(v, g_reuseId)) {
                return;
            }
            VZFViewReuseInfo* reuseInfo = [[VZFViewReuseInfo alloc]initWithView:v didEnterReusePoolBlock:nil willLeaveReusePoolBlock:nil];
            objc_setAssociatedObject(v, g_reuseId, reuseInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        void mountingChildView(UIView* child, UIView* parent){
            
            if (!child || !parent) {
                return;
            }
            
            if (objc_getAssociatedObject(child, g_reuseId)) {
                return;
            }
            
            VZFViewReuseInfo* reuseInfo = [[VZFViewReuseInfo alloc]initWithView:child didEnterReusePoolBlock:nil willLeaveReusePoolBlock:nil];
            objc_setAssociatedObject(child, g_reuseId, reuseInfo,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            VZFViewReuseInfo* parentReuseInfo = objc_getAssociatedObject(parent, g_reuseId);
            VZFCAssertNotNil(parentReuseInfo, @"Expected parent reuse info !");
            [parentReuseInfo addChildReuseInfo:reuseInfo];
        
        }
        
        bool nodeHaveChildren(VZFNode* node){
            
            if ([node isKindOfClass:[VZFCompositeNode class]]) {
                VZFCompositeNode* compoundNode  = (VZFCompositeNode* )node;
                return nodeHaveChildren(compoundNode.node);
                
            }
            else{
                
                if ([node isKindOfClass:[VZFStackNode class]]) {
                    VZFStackNode* stackNode = (VZFStackNode* )node;
                    return stackNode.children.size() > 0;
                }
                else{
                    return NO;
                }
            }
        }
        
        VZFNode* unwrapNode(VZFNode* node){
        
            if ([node isKindOfClass:[VZFCompositeNode class]]) {
                VZFCompositeNode* compoundNode = (VZFCompositeNode* )node;
                return compoundNode.node;
            }
            else{
                return node;
            }
        }
        
        void createView(UIView* v, const ViewClass& clz, UIView* parentView){
        
            if (!v || !parentView) {
                return;
            }
            
            VZFCAssertNil(objc_getAssociatedObject(v, g_reuseId), @"a resuse info is found on a new created view!");
            
            VZFViewReuseInfo* reuseInfo = [[VZFViewReuseInfo alloc]initWithView:v
                                                         didEnterReusePoolBlock:clz.didEnterReusePool()
                                                        willLeaveReusePoolBlock:clz.willLeaveReusePool()];
            objc_setAssociatedObject(v,g_reuseId, reuseInfo,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            VZFViewReuseInfo* parentReuseInfo = objc_getAssociatedObject(parentView, g_reuseId);
            VZFCAssertNotNil(parentReuseInfo, @"parent reuse info not exist!");
            [parentReuseInfo addChildReuseInfo:reuseInfo];
            
        }
        void hide(UIView* v){
            VZFViewReuseInfo* reuseInfo = objc_getAssociatedObject(v, g_reuseId);
            VZFCAssertNotNil(reuseInfo, @"reuse info is missing!");
            [reuseInfo hide];
        }
        void unhide(UIView* v){
            VZFViewReuseInfo* reuseInfo = objc_getAssociatedObject(v, g_reuseId);
            VZFCAssertNotNil(reuseInfo, @"reuse info is missing!");
            [reuseInfo unHide];
        }

    }
}