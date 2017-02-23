//
//  VZFNodeLifeCycle.h
//  O2OReact
//
//  Created by moxin on 16/7/11.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#ifndef VZFNodeLifeCycle_h
#define VZFNodeLifeCycle_h

typedef NS_ENUM(NSUInteger, VZFNodeLifeCycleState) {
    VZFNodeStateUnmounted = 0,
    VZFNodeStateMounting,
    VZFNodeStateMounted,
    VZFNodeStateRemounting,
    VZFNodeStateUnmounting,
};

@interface VZFNode()


/**
 Render之前调用
 */
- (void)willMount NS_REQUIRES_SUPER;
- (void)willRemount NS_REQUIRES_SUPER;

/**
 Render之后调用
 */
- (void)didMount NS_REQUIRES_SUPER;
- (void)didRemount NS_REQUIRES_SUPER;
- (void)willUnmount NS_REQUIRES_SUPER;
- (void)didUnmount NS_REQUIRES_SUPER;
- (void)didAquireBackingView:(UIView *)view NS_REQUIRES_SUPER;
- (void)willReleaseBackingView:(UIView *)view NS_REQUIRES_SUPER;

@end

static inline NSString *VZFNodeStateName(VZFNodeLifeCycleState state)
{
    switch (state) {
        case VZFNodeStateUnmounted:
            return @"unmounted";
        case VZFNodeStateMounting:
            return @"mounting";
        case VZFNodeStateMounted:
            return @"mounted";
        case VZFNodeStateRemounting:
            return @"remounting";
        case VZFNodeStateUnmounting:
            return @"unmounting";
        default:
            return @"unknown";
    };
}


#endif /* VZFNodeLifeCycle_h */
