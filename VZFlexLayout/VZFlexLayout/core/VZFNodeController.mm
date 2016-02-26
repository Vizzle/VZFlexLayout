//
//  VZFNodeController.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/25.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeController.h"
#import "VZFNodeControllerInternal.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"

@interface VZFNodeController ()
{
    VZFNode *_previousNode;
    BOOL _updatingNode;
}
@end

@implementation VZFNodeController

- (void)nodeWillMount:(id)node {
    if (node != _node) {
        [self willUpdateNode];
        _previousNode = _node;
        _node = node;
        _updatingNode = YES;
    }
}

- (void)nodeDidMount:(VZFNode *)node {
    if (_updatingNode) {
        [self didUpdateNode];
        _previousNode = nil;
        _updatingNode = NO;
    }
}

- (void)willUpdateNode {}
- (void)didUpdateNode {}

- (id)nextResponder {
    return self.node.parentNode;
}

- (id)responderForSelector:(SEL)selector {
    return [self respondsToSelector:selector] ? self : [self.nextResponder responderForSelector:selector];
}

@end
