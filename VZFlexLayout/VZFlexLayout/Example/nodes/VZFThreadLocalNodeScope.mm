//
//  VZFThreadLocalNodeScope.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/10.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFThreadLocalNodeScope.h"
#import "VZFRootScope.h"
#import "VZFMacros.h"
#import <pthread.h>

static pthread_key_t _threadKey()
{
    static pthread_key_t thread_key;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        (void)pthread_key_create(&thread_key, nullptr);
    });
    return thread_key;
}

VZFThreadLocalNodeScope *VZFThreadLocalNodeScope::currentScope()
{
    VZFThreadLocalNodeScope* scope =  (VZFThreadLocalNodeScope *)pthread_getspecific(_threadKey());
    return scope;
}

VZFThreadLocalNodeScope::VZFThreadLocalNodeScope(VZFRootScope *previousScopeRoot,
                                                 NSDictionary* updates)
: newScopeRoot([previousScopeRoot newRootScope]), stateUpdateFunc(updates), stack()
{
    VZFCAssert(VZFThreadLocalNodeScope::currentScope() == nullptr, @"CKThreadLocalComponentScope already exists");
    stack.push({[newScopeRoot rootFrame], [previousScopeRoot rootFrame]});
    pthread_setspecific(_threadKey(), this);
}

VZFThreadLocalNodeScope::~VZFThreadLocalNodeScope()
{
    stack.pop();
    VZFCAssert(stack.empty(), @"Didn't expect stack to contain anything in destructor");
    pthread_setspecific(_threadKey(), nullptr);
}