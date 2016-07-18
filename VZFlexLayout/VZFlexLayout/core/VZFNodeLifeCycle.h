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

- (void)willMount NS_REQUIRES_SUPER;
- (void)willRemount NS_REQUIRES_SUPER;
- (void)didMount NS_REQUIRES_SUPER;
- (void)didRemount NS_REQUIRES_SUPER;
- (void)willUnmount NS_REQUIRES_SUPER;
- (void)didUnmount NS_REQUIRES_SUPER;
- (void)didAquireBackingView NS_REQUIRES_SUPER;
- (void)willReleaseBackingView NS_REQUIRES_SUPER;

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
