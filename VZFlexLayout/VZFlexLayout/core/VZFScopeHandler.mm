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
    id _rootScopeId;
}

+ (VZFScopeHandler* )scopeHandlerForNode:(VZFNode* )node{

    VZFLocalScope* localScope = [VZFScopeManager sharedInstance].currentLocalScope;
    if (localScope) {
        VZFScopeHandler* handler = [localScope top].newScopeFrame.handler;
        if ([handler bindToNode:node]) {
            return handler;
        }
    }
    return nil;

}

- (instancetype)initWithListener:(id<VZFStateListener>)listener
             RootScopeIdentifier:(id)rootScopeId
                       NodeClass:(Class )nodeClass
                InitialStateFunc:(id(^)(void))stateFunc{

    static int32_t scopeId = 0;
    return  [self initWithListener:listener
                   ScopeIdentifier: @(OSAtomicIncrement32(&scopeId))
               RootScopeIdentifier:rootScopeId
                         NodeClass:nodeClass
                      InitialState:stateFunc?stateFunc():[nodeClass initialState]];

}





- (instancetype)initWithListener:(id<VZFStateListener>)listener
                 ScopeIdentifier:(id)identifier
             RootScopeIdentifier:(id)rootScopeId
                       NodeClass:(Class )nodeClass
                    InitialState:(id)state{

    self = [super init];
    if (self) {
        
        _listener        = listener;
        _nodeClass       = nodeClass;
        _scopeIdentifier = identifier;
        _rootScopeId     = rootScopeId;
        _state = state;
        _controller = newController(nodeClass);
    }
    return self;
}


- (instancetype)newHandler{

    return [[VZFScopeHandler alloc]initWithListener:_listener ScopeIdentifier:_scopeIdentifier RootScopeIdentifier:_rootScopeId NodeClass:_nodeClass InitialState:_state];
}

- (instancetype)newHandlerWithLatestState:(NSDictionary* )multiStates{

    id identifier = _scopeIdentifier;
    NSArray* stateFuncs = multiStates[identifier];
    
    id state = _state;
    for(id(^func)(id oldState) in stateFuncs){
    
        state = func(state);
    }
    _state = state;
    return [self newHandler];
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
    if (_listener) {
        [_listener nodeScopeHandleWithIdentifier:_scopeIdentifier rootIdentifier:_rootScopeId didReceiveStateUpdate:stateBlock];
    }

}

- (NSString* )description{

    /**
     __weak id<VZFStateListener> _listener;
     Class _nodeClass;
     id _scopeIdentifier;
     BOOL _inUse;
     id _rootScopeId;
     */
    return [NSString stringWithFormat:@"%@-->{\nlistener: %@\n node: %@\n scopeId: %@\n inUSE: %d\n rootScopeId:%@\n}",self.class,_listener,_nodeClass,_scopeIdentifier,_inUse,_rootScopeId];

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
