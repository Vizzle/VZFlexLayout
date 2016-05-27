//
//  VZFNodeThreadLocalScope.m
//  O2OReact
//
//  Created by moxin on 16/5/11.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFThreadLocalScope.h"
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

VZFThreadLocalScope *VZFThreadLocalScope::currentScope()
{
    VZFThreadLocalScope* scope =  (VZFThreadLocalScope *)pthread_getspecific(_threadKey());
    return scope;
}

VZFThreadLocalScope::VZFThreadLocalScope(VZFRootScope *previousScopeRoot,NSDictionary* updates)
: newScopeRoot([previousScopeRoot newRootScope]), stateUpdateFunc(updates), stack()
{
    VZFCAssert(VZFThreadLocalScope::currentScope() == nullptr, @"LocalScope已经存在");
    stack.push({[newScopeRoot rootFrame], [previousScopeRoot rootFrame]});
    pthread_setspecific(_threadKey(), this);
}

VZFThreadLocalScope::~VZFThreadLocalScope()
{
    stack.pop();
    VZFCAssert(stack.empty(), @"local scope析构的时stack不为空");
    pthread_setspecific(_threadKey(), nullptr);
}