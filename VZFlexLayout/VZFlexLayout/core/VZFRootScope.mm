//
//  VZFRootScope.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/25.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFRootScope.h"
#import "VZFScopeFrame.h"
#import <libkern/OSAtomic.h>

@implementation VZFRootScope

+ (instancetype)rootScopeWithListener:(id<VZFStateListener>)listener{
    
    static int32_t nextRootId = 0;
    return [[self alloc] initWithRootScopeListener:listener rootScopeId:OSAtomicIncrement32(&nextRootId)];
    
}

- (instancetype)initWithRootScopeListener:(id<VZFStateListener>)listener rootScopeId:(int32_t)rootId{
    
    self = [super  init];
    if (self) {
        _listener = listener;
        _rootScopeId = rootId;
        _rootFrame = [[VZFScopeFrame alloc]initWithScopeHandler:nil];
    }
    return self;
}
- (instancetype)newRootScope{
    return [[VZFRootScope alloc]initWithRootScopeListener:_listener rootScopeId:_rootScopeId];
}

- (NSString* )description{

    return [NSString stringWithFormat:@"%@ -> {\n listener:%@\n scopeId:%d\n rootFrame:%@\n}",[self class],_listener,_rootScopeId,_rootFrame];

}

@end
