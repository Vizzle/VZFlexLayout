//
//  VZFStateScope.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScope.h"
#include <libkern/OSAtomic.h>
#import "VZFScopeManager.h"
#import "VZFScopeHandler.h"
#import "VZFNodeInternal.h"

namespace VZ {
    
    Scope::Scope(Class clz, id scopeIdentifier, id(^initialStateCreator)(void)):_scopeIdentifier(scopeIdentifier),_nodeClass(clz){
       
        
        static int32_t scopeId = 0;
        if (!scopeIdentifier) {
            scopeIdentifier = @(OSAtomicIncrement32(&scopeId));
        }
        
        id initialState = nil;
        if (!initialStateCreator) {
            initialState = [clz initialState];
        }
        else{
            initialState = initialStateCreator();
        }
        
        VZFScopeHandler* handler = [VZFScopeManager pushScopeHandlerWithScopeIdentifier:scopeIdentifier NodeClass:clz initialState:initialState];
        _state = handler.state;
    
    };
    
    Scope::~Scope(){
        
        [VZFScopeManager popScopeHandler];
        
    }
    
    id Scope::state() const {
        return _state;
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
