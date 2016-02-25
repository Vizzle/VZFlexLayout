//
//  VZFScopeManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScopeManager.h"
#import "VZFScopeHandler.h"
#include <stack>

@implementation VZFScopeManager
{
    //这个数据结构再想想,应该用有序哈希
//    NSMutableDictionary* _map;
     NSMutableArray*  _stack;

}

+ (instancetype)sharedInstance{

    static VZFScopeManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VZFScopeManager new];
    });
    return instance;

}

- (id)init{

    self = [super init];
    if (self) {
        _stack = [NSMutableArray new];
//        _map = [NSMutableDictionary new];
    }
    return self;
}


+ (VZFScopeHandler* )pushScopeHandlerWithScopeIdentifier:(id)identifier NodeClass:(Class)clz initialState:(id)state{


    VZFScopeHandler* handler = [[VZFScopeHandler alloc]initWithScopeIdentifier:identifier
                                                                     NodeClass:clz
                                                                  InitialState:state];
    
//    [[VZFScopeManager sharedInstance] -> _map setObject:handler forKey:identifier];
    [[VZFScopeManager sharedInstance] -> _stack addObject:handler];
    return handler;
}

+ (void)popScopeHandler{

    [[VZFScopeManager sharedInstance] -> _stack removeLastObject];
}

+ (VZFScopeHandler* )scopeHandlerForNode:(VZFNode *)node{

    
    VZFScopeHandler* handler = [[VZFScopeManager sharedInstance] -> _stack lastObject];
    if ([handler bindToNode:node]) {
        return  handler;
    }
    else{

        //need assert here !
        return nil;
    }
}


@end
