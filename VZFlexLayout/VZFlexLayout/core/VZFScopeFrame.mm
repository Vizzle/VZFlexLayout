//
//  VZFScopeFrame.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScopeFrame.h"
#import "VZFScopeHandler.h"
#import "VZFRootScope.h"
#include <unordered_map>
#include <string>
#import "VZFUtils.h"

using namespace VZ;
@implementation VZFScopeFrame{
    NSMutableDictionary* _children;
}


- (id)initWithScopeHandler:(VZFScopeHandler *)scopeHandler{

    self = [super init];
    if (self) {
        _handler = scopeHandler;
        _children = [NSMutableDictionary new];
    }
    return self;
}
+ (ScopeFramePair)scopeFramePair:(const ScopeFramePair& )pair
                              NewRoot:(VZFRootScope* )newRoot
                            NodeClass:(Class )nodeClz
                           Identifier:(id)identifier
                  InitialStateCreator:(id (^)())initialStateCreator
                         StateUpdates:(NSDictionary* )stateUpdatesFunc{



    VZFScopeFrame *existingChild = nil;;
    if (pair.oldScopeFrame) {
        
        NSMutableDictionary* oldFrameChildren = pair.oldScopeFrame->_children;
        NSString* key = VZ::Hash::ScopeHashKey(nodeClz, identifier);
        VZFScopeFrame* value = [oldFrameChildren objectForKey:key];
        if (value) {
            existingChild = value;
        }
    }
    
    VZFScopeHandler* newHandler = nil;
    if (existingChild) {
        newHandler = [existingChild.handler newHandlerWithLatestState:stateUpdatesFunc];
    }
    else{
        newHandler = [[VZFScopeHandler alloc]initWithListener:newRoot.listener
                                          RootScopeIdentifier:@(newRoot.rootScopeId)
                                       CurrentScopeIdentifier:identifier
                                                    NodeClass:nodeClz
                                             InitialStateFunc:initialStateCreator];
    }
    
    VZFScopeFrame* newFrame = [[VZFScopeFrame alloc]initWithScopeHandler:newHandler];
    NSString* newKey = VZ::Hash::ScopeHashKey(nodeClz, identifier);
    if ([[pair.newScopeFrame->_children allKeys] containsObject:newKey]) {
        //assert
        NSAssert(false, @"Scope collision: attempting to create duplicate scope %@:%@", nodeClz, identifier);
    }
    else{
        [pair.newScopeFrame->_children setObject:newFrame forKey:newKey];
    }
    
    return {.newScopeFrame = newFrame, .oldScopeFrame = existingChild};


}

- (NSString* )description{
    
    return [NSString stringWithFormat:@"%@ -> {\n handler:%@\n children:%@\n}",[self class],_handler,_children];
    
}

@end
