//
//  VZFNodeThreadLocalScope.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeThreadLocalScope.h"
#include <pthread.h>
#import "VZFRootScope.h"

static pthread_key_t _threadKey()
{
    static pthread_key_t thread_key;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        (void)pthread_key_create(&thread_key, nullptr);
    });
    return thread_key;
}

VZFNodeThreadLocalScope *VZFNodeThreadLocalScope::currentScope()
{
    VZFNodeThreadLocalScope* scope =  (VZFNodeThreadLocalScope *)pthread_getspecific(_threadKey());
    return scope;
}

VZFNodeThreadLocalScope::VZFNodeThreadLocalScope(VZFRootScope* previousRootScope, NSDictionary* funcs)
: newRootScope([previousRootScope newRootScope]), stateUpdateFuncs(funcs), stack()
{
//    CKCAssert(CKThreadLocalComponentScope::currentScope() == nullptr, @"CKThreadLocalComponentScope already exists");
    stack.push({[newRootScope rootFrame], [previousRootScope rootFrame]});
    pthread_setspecific(_threadKey(), this);
}

VZFNodeThreadLocalScope::~VZFNodeThreadLocalScope()
{
    stack.pop();
//    CKCAssert(scopeFrameStack.empty(), @"Didn't expect stack to contain anything in destructor");
    pthread_setspecific(_threadKey(), nullptr);
}

