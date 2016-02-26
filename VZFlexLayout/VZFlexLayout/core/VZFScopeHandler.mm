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
#include "VZFLocker.h"

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
        _controller = newController(nodeClass);
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

static Class controllerClassForNodeClass(Class nodeClass)
{
    if (nodeClass == [VZFNode class]) {
        return Nil;
    }
    
    static VZ::StaticMutex mutex = VZ_MUTEX_INITIALIZER; // protects cache
    VZ::StaticMutexLocker l(mutex);
    
    static std::unordered_map<Class, Class> *cache = new std::unordered_map<Class, Class>();
    const auto &it = cache->find(nodeClass);
    if (it == cache->end()) {
        Class c = NSClassFromString([NSStringFromClass(nodeClass) stringByAppendingString:@"Controller"]);
        
        cache->insert({nodeClass, c});
        return c;
    }
    return it->second;
}

static VZFNodeController* newController(Class nodeClass) {
    Class controllerClass = controllerClassForNodeClass(nodeClass);
    if (controllerClass) {
        NSCAssert([controllerClass isSubclassOfClass:[VZFNodeController class]],
                  @"%@ must inherit from CKComponentController", controllerClass);
        return [[controllerClass alloc] init];
    }
    return nil;
}

@end
