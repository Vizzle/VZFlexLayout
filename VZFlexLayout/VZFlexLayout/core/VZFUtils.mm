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

    
    namespace Mounting{
        
        
        const void* g_reuseId = &g_reuseId;
        void mountingRootView(UIView* v){
            
            //todo//
        }
        
        void mountingChildView(UIView* child, UIView* parent){
            
            //todo//
        
        }
        
        void destroyView(UIView* v){
        
            if ([v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                id<VZFNodeBackingViewInterface> backingView = (id<VZFNodeBackingViewInterface>)v;
                if ([backingView respondsToSelector:@selector(dead)]) {
                    [backingView dead];
                }
            }
        }
        
        void createView(UIView* v){
        
            if ([v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                id<VZFNodeBackingViewInterface> backingView = (id<VZFNodeBackingViewInterface>)v;
                if ([backingView respondsToSelector:@selector(born)]) {
                    [backingView born];
                }
            }
        }
        
        void reset(UIView* v){
        
            if ([v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                id<VZFNodeBackingViewInterface> backingView = (id<VZFNodeBackingViewInterface>)v;
                if ([backingView respondsToSelector:@selector(resetState)]) {
                    [backingView resetState];
                }
            }
        
        }
        
        void prepareForReuse(UIView* v){
            
            if ([v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                id<VZFNodeBackingViewInterface> backingView = (id<VZFNodeBackingViewInterface>)v;
                if ([backingView respondsToSelector:@selector(prepareForReuse)]) {
                    [backingView prepareForReuse];
                }

            }
        }
        
        void hide(UIView* v){
            
            if ([v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                id<VZFNodeBackingViewInterface> backingView = (id<VZFNodeBackingViewInterface>)v;
                if ([backingView respondsToSelector:@selector(willEnterReusePool)]) {
                    [backingView willEnterReusePool];
                }
            }
        }
        void unhide(UIView* v){
            
            if ([v.class conformsToProtocol:@protocol(VZFNodeBackingViewInterface)]) {
                id<VZFNodeBackingViewInterface> backingView = (id<VZFNodeBackingViewInterface>)v;
                if ([backingView respondsToSelector:@selector(didLeaveReusePool)]) {
                    [backingView didLeaveReusePool];
                }

            }
        }

    }
}
