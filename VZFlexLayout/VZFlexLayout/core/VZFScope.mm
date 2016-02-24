//
//  VZFStateScope.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScope.h"
#include <libkern/OSAtomic.h>
namespace VZ {
    
    VZFScope::VZFScope(Class componentClz, id scopeId, id (^initialStateCreator)(void)){
        _state = initialStateCreator();
        _scopeId = scopeId;
    };
    
    id VZFScope::state() const {
        return _state;
    }
    id VZFScope::scopeId() const{
        return _scopeId;
    }
    
}

@implementation VZFRootScope
{
    
}

+ (instancetype)rootScopeWithListener:(id<VZFStateListener>)listener{
    
    static int32_t nextRootId = 0;
    return [[self alloc] initWithRootScopeListener:listener rootScopeId:OSAtomicIncrement32(&nextRootId)];
    
}

- (instancetype)initWithRootScopeListener:(id<VZFStateListener>)listener rootScopeId:(int32_t)rootId{

    self = [super  init];
    if (self) {
        _listener = listener;
        _rootScopeId = rootId;
    }
    return self;
}
- (instancetype)newRootScope{
    return [self  initWithRootScopeListener:_listener rootScopeId:_rootScopeId];
}

@end
