//
//  VZFActionWrapper.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFActionWrapper.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeSubClass.h"


@implementation VZFBlockWrapper
- (instancetype)initWithBlock:(UIControlActionBlock)block {
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}

- (void) dealloc {
    self.block = nil;
}

- (void) invoke:(UIControl *)sender event:(UIEvent *)event {
    self.block(sender.node);
}

- (void)invoke:(UIGestureRecognizer *)sender {
    self.block(sender.view.node);
}

@end


@implementation VZFSelectorWrapper
{
    SEL _selector;
}

- (instancetype)initWithSelector:(SEL)selector {
    if (self = [super init]) {
        _selector = selector;
    }
    return self;
}

- (void)invoke:(UIControl *)sender event:(UIEvent *)event {
    VZFNode *node = sender.node;
    id responder = [node targetForAction:_selector withSender:sender];
    NSAssert(responder, @"could not found responder for action '%@'", NSStringFromSelector(_selector));
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [responder performSelector:_selector withObject:node withObject:event];
#pragma clang diagnostic pop
}

- (void)invoke:(UIGestureRecognizer *)sender {
    VZFNode *node = sender.view.node;
    id responder = [node targetForAction:_selector withSender:sender];
    NSAssert(responder, @"could not found responder for action '%@'", NSStringFromSelector(_selector));
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [responder performSelector:_selector withObject:node];
#pragma clang diagnostic pop
}

@end


id<VZFActionWrapper> vz_actionWrapper(VZ::ActionWrapper action) {
    if (action.block) {
        return [[VZFBlockWrapper alloc] initWithBlock:action.block];
    }
    else if (action.selector) {
        return [[VZFSelectorWrapper alloc] initWithSelector:action.selector];
    }
    return nil;
}
