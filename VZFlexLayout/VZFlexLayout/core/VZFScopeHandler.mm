//
//  VZFScopeHandler.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScopeHandler.h"
#import "VZFNodeInternal.h"
#include <libkern/OSAtomic.h>

@implementation VZFScopeHandler
{
    __weak id<VZFStateListener> _listener;
    Class _nodeClass;
    id _scopeIdentifier;
    BOOL _inUse;
//    int32_t _rootScopeId;
}

+ (instancetype)scopeHandlerForNode:(VZFNode* )node{

    
    return nil;

}


- (instancetype)initWithScopeIdentifier:(id)identifier
                              NodeClass:(Class)nodeClass
                           InitialState:(id)state
{

    
    static int32_t scopeId = 0;
    if (identifier == nil) {
        identifier = @(OSAtomicIncrement32(&scopeId));
    }
    return [self initWithListener:nil
                  ScopeIdentifier:identifier
                        NodeClass:nodeClass
                            State:state];

}


- (instancetype)initWithListener:(id<VZFStateListener>)listner
                 ScopeIdentifier:(id)scopdId
                       NodeClass:(Class )nodeClass
                           State:(id)state{
    
    self = [super init];
    if (self) {
        
        _listener        = listner;
        _nodeClass       = nodeClass;
        _scopeIdentifier = scopdId;
//        _rootScopeId = rootId;
        _state = state;
    
    }
    return self;
}

//- (instancetype)newHandleWithStateUpdates:(const VZFNodeStateUpdateMap &)stateUpdates{
//    id state = _state;
//    const auto range = stateUpdates.equal_range(_scopeId);
//    for (auto it = range.first; it != range.second; ++it) {
//        state = it->second(state);
//    }
//    
//    //返回一个新的handler，而不是原来的状态
//    return [[VZFScopeHandler alloc] initWithListener:_listener
//                                             ScopeId:_scopeId
//                                                NodeClass:_nodeClass
//                                               State:state];
//}

- (instancetype)newHandler{

    return [[VZFScopeHandler alloc]initWithListener:_listener
                                    ScopeIdentifier:_scopeIdentifier
                                          NodeClass:_nodeClass
                                              State:_state];
}

- (BOOL)bindToNode:(VZFNode* )node{
   
    if (_inUse) {
        return NO;
    }
    else{
        if ([node isMemberOfClass:_nodeClass]) {
            _inUse = YES;
            return YES;
        }
        else{
            return NO;
        }
    }
}

- (void)updateState:(id(^)(id))stateBlock{

    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateState:stateBlock];
        });
        return;
    }
    
    _state = stateBlock(_state);
    
    
    if (self.isRootHandler) {
        
        if ([_listener respondsToSelector:@selector(nodeStateUpdateDidChanged)]) {
            [_listener nodeStateUpdateDidChanged];
        }
    }

}

- (id)copyWithZone:(nullable NSZone *)zone{

    VZFScopeHandler* newHandler = [[self class] allocWithZone:zone];
    newHandler -> _state = self.state;
    newHandler -> _isRootHandler = self.isRootHandler;
    return newHandler;
}

static VZFNodeController* newController(Class componentClass) {
    return nil;
}

@end
