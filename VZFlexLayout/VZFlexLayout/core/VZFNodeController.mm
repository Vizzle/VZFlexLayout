//
//  VZFNodeController.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/25.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeController.h"
#import "VZFMacros.h"
#import "VZFNodeControllerInternal.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"

typedef NS_ENUM(NSUInteger, VZFNodeControllerState) {
    VZFNodeControllerStateUnmounted = 0,
    VZFNodeControllerStateMounting,
    VZFNodeControllerStateMounted,
    VZFNodeControllerStateRemounting,
    VZFNodeControllerStateUnmounting,
};

static inline NSString *controllerStateName(VZFNodeControllerState state)
{
    switch (state) {
        case VZFNodeControllerStateUnmounted:
            return @"unmounted";
        case VZFNodeControllerStateMounting:
            return @"mounting";
        case VZFNodeControllerStateMounted:
            return @"mounted";
        case VZFNodeControllerStateRemounting:
            return @"remounting";
        case VZFNodeControllerStateUnmounting:
            return @"unmounting";
        default:
            return @"unknown";
    };
}

@interface VZFNodeController ()
{
    VZFNodeControllerState _state;
    VZFNode *_previousNode;
    BOOL _updatingNode;
}
@end

@implementation VZFNodeController

- (id)nextResponder {
    return [self.node nextResponderAfterController];
}

- (id)targetForAction:(SEL)action withSender:(id)sender
{
    return [self respondsToSelector:action] ? self : [[self nextResponder] targetForAction:action withSender:sender];
}

- (void)willUpdateNode {}
- (void)willMountNode{}
- (void)willRemountNode{}
- (void)didUpdateNode {}
- (void)didMountNode{}
- (void)didRemountNode{}
- (void)willUnmountNode{}
- (void)didUnmountNode{}
- (void)willReleaseBackingView{}
- (void)didAquireView{}

- (void)nodeWillMount:(id)node {
    if (node != _node) {
        [self willUpdateNode];
        _previousNode = _node;
        _node = node;
        _updatingNode = YES;
    }
    switch (_state) {
        case VZFNodeControllerStateUnmounted:
        {
            _state = VZFNodeControllerStateMounting;
            [self willMountNode];
            break;
        }
        case VZFNodeControllerStateMounted:
        {
            _state = VZFNodeControllerStateRemounting;
            [self willRemountNode];
            break;
        }
        default:
        {
            VZFAssert(NO, @"Controller State:[%@] Error: willmount -> '%@' ",[self class],controllerStateName(_state));
            break;
        }
    }
}

- (void)nodeDidMount:(VZFNode *)node {
    
    switch (_state) {
        case VZFNodeControllerStateMounting:
        {
            _state = VZFNodeControllerStateMounted;
            [self didMountNode];
            break;
        }
        case VZFNodeControllerStateRemounting:{
            _state = VZFNodeControllerStateMounted;
            [self didRemountNode];
            break;
        }
        default:
        {
            VZFAssert(NO, @"Controller State:[%@] Error: didmount -> '%@' ",[self class],controllerStateName(_state));
            break;
        }
    }
    
    if (_updatingNode) {
        [self didUpdateNode];
        _previousNode = nil;
        _updatingNode = NO;
    }
}

- (void)nodeWillUnmount:(VZFNode *)node{

    switch (_state) {
        case VZFNodeControllerStateMounted:
        {
            // The "old" version of a component may be unmounted after the new version has finished remounting.
            if (node == _node) {
                _state = VZFNodeControllerStateUnmounting;
                [self willUnmountNode];
            }
            break;
        }
        case VZFNodeControllerStateRemounting:
        {
            VZFAssert(node != _node, @"Didn't expect the new node to be unmounting during remount");
            break;
        }
        default:
        {
            VZFAssert(NO, @"Controller State:[%@] Error: will unmount -> '%@' ",[self class],controllerStateName(_state));
            break;
        }
    }
}
- (void)nodeDidUnmount:(VZFNode *)node{

    switch (_state) {
        case VZFNodeControllerStateUnmounting:
        {
            VZFAssert(node == _node, @"Unexpected component mismatch during unmount from unmounting");
            _state = VZFNodeControllerStateUnmounted;
            [self didUnmountNode];
            break;
        }
        case VZFNodeControllerStateRemounting:
        {
            VZFAssert(node != _node, @"Didn't expect the new component to be unmounted during remount");
            break;
        }
        case VZFNodeControllerStateMounted:
        {
            VZFAssert(node != _node, @"Didn't expect the new component to be unmounted while mounted");
            break;
        }
        default:{
            VZFAssert(NO, @"Controller State:[%@] Error: did unmount -> '%@' ",[self class],controllerStateName(_state));
            break;
        }
    }
    
}

- (void)node:(VZFNode* )node willReleaseBackingView:(UIView* )view{
    if (node == _node) {
        [self _releaseView];
    }

}
- (void)node:(VZFNode* )node didAquireBackingView:(UIView* )view{

    if (node == _node) {
        if (view != _view) {
            if (_view) {
                VZFAssertNotNil(_previousNode, @"Only expect to acquire a new view before relinquishing old if updating");
                [self _releaseView];
            }
            _view = view;
            [self didAquireView];
        }
    }

}

- (void)_releaseView{
    [self willReleaseBackingView];
    _view = nil;
}





@end
