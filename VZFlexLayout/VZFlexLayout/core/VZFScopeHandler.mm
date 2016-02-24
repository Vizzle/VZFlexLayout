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
    __weak VZFNode* _node;
//    Class _nodeClass;
    int32_t _scopeId;
    int32_t _rootScopeId;
}

- (instancetype)initWithListener:(id<VZFStateListener>)listener
                     rootScopeId:(int32_t)rootScopeId
                       Node:(VZFNode* )node
                       PropsFunc:(id(^)(void))propCreator{


    static int32_t scopeId = 0;
    return [self initWithListener:listener
                          ScopeId:OSAtomicIncrement32(&scopeId)
                      RootScopeId:rootScopeId
                             Node:node
                            State:propCreator?propCreator():[[node class] initialState]];

}


- (instancetype)initWithListener:(id<VZFStateListener>)listner
                         ScopeId:(int32_t)scopdId
                     RootScopeId:(int32_t)rootId
                       Node:(VZFNode* )node
                           State:(id)state{
    
    self = [super init];
    if (self) {
        
        _listener = listner;
        _node = node;
        _scopeId = scopdId;
        _rootScopeId = rootId;
        _state = state;
    
    }
    return self;
}

- (instancetype)newHandleWithStateUpdates:(const VZFNodeStateUpdateMap &)stateUpdates{

    id state = _state;
    const auto range = stateUpdates.equal_range(_scopeId);
    for (auto it = range.first; it != range.second; ++it) {
        state = it->second(state);
    }
    
    //返回一个新的handler，而不是原来的状态
    return [[VZFScopeHandler alloc] initWithListener:_listener
                                             ScopeId:_scopeId
                                         RootScopeId:_rootScopeId
                                                Node:_node
                                               State:state];
}

- (void)updateState:(id(^)(id))stateBlock{

    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateState:stateBlock];
        });
        return;
    }
    if ([_listener respondsToSelector:@selector(nodeStateUpdateWithScopeId:rootScopeId:Func:)]) {
        [_listener nodeStateUpdateWithScopeId:_scopeId
                                  rootScopeId:_rootScopeId
                                         Func:stateBlock];
    }
}
@end
