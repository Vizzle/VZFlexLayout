//
//  VZFUtils.c
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "VZFUtils.h"
#import "VZFMacros.h"
#import "VZFNodeViewClass.h"
#import "VZFStackNode.h"
#import "VZFCompositeNode.h"
#import "VZFNodeBackingViewInterface.h"

namespace VZ{
    namespace Helper{
      
        std::string stringFromPointer(const void* ptr){
            char buf[64];
            snprintf(buf, sizeof(buf), "%p", ptr);
            return buf;
        }
        
        CGFloat screenScale(){
            
            static CGFloat _scale = 1;
            static dispatch_once_t onceToken = 0;
            dispatch_once(&onceToken, ^{
                _scale = [UIScreen mainScreen].scale;
            });
            return _scale;
        }
    }
    
    namespace LifeCycle{
    
        //在主线程执行释放
        void performDeallocOnMainThread(void(^block)()){
        VZFDispatchMain(0, ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
            
                if (block) {
                    block();
                }
            });
        }
        
        //在一个串行异步队列中执行释放
        void performDeallocOnBackgroundThread(void(^block)()){
        
            NSString* vz_dellocation_block_name = @"com.React.DeallocationQueue";
            static dispatch_queue_t queue = NULL;
            static dispatch_once_t onceToken = 0;
            dispatch_once(&onceToken, ^{
                queue = dispatch_queue_create([vz_dellocation_block_name UTF8String], DISPATCH_QUEUE_SERIAL);
            });
            
            if (block) {
                 dispatch_async(queue, VZF_NAMED_DISPATCH_BLOCK(vz_dellocation_block_name, block));
                
            }
           
        }
    }
    
    

    
    namespace Mounting{
        
        
        const void* g_reuseId = &g_reuseId;
        void mountingRootView(UIView* v){
            
            //todo//
        }
        
        void mountingChildView(UIView* child, UIView* parent){
            
            //todo//
        
        }
        
        void destroyView(UIView* v){
            if ([v respondsToSelector:@selector(dead)] && [v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                [(id<VZFNodeBackingViewInterface>)v dead];
            }
        }
        
        void createView(UIView* v){
            if ([v respondsToSelector:@selector(born)] && [v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                [(id<VZFNodeBackingViewInterface>)v born];
            }
        }
        
        void reset(UIView* v){
            if ([v respondsToSelector:@selector(resetState)] && [v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                [(id<VZFNodeBackingViewInterface>)v resetState];
            }
        }
        
        void prepareForReuse(UIView* v){
            if ([v respondsToSelector:@selector(prepareForReuse)] && [v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                [(id<VZFNodeBackingViewInterface>)v prepareForReuse];
            }
        }
        
        void hide(UIView* v){
            if ([v respondsToSelector:@selector(willEnterReusePool)] && [v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                [(id<VZFNodeBackingViewInterface>)v willEnterReusePool];
            }
        }
        void unhide(UIView* v){
            if ([v respondsToSelector:@selector(didLeaveReusePool)] && [v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                [(id<VZFNodeBackingViewInterface>)v didLeaveReusePool];
            }
        }

    }
}
