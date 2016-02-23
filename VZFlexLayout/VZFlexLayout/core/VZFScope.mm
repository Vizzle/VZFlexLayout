//
//  VZFStateScope.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScope.h"

namespace VZ {
    
    VZFScope::VZFScope(Class componentClz, id scopeId, id (^initialStateCreator)(void)){
    
        
    };
    
    id VZFScope::state() const {
        return _state;
    }
    
}

@implementation VZFRootScope
{
    
}

+ (instancetype)rootScopeWithListener:(id<VZFStateListener>)listener{
    
    static int32_t nextRootId = 0;
    return [[self alloc] initWithRootScopeListener:listener rootScopeId:nextRootId];
    
}

- (instancetype)initWithRootScopeListener:(id<VZFStateListener>)listener rootScopeId:(int32_t)rootId{

    self = [super  init];
    if (self) {
        _listener = listener;
        _rootScopeId = rootId;
    }
    return self;
}

@end
