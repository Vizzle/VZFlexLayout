//
//  VZFScopeFrame.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScopeFrame.h"
#import "VZFScopeHandler.h"
#include <unordered_map>
#include <string>
#import "VZFUtils.h"

namespace VZ {
    struct _StateScopeKey {
        Class __unsafe_unretained nodeClass;
        id identifier;
        
        bool operator==(const _StateScopeKey &v) const {
            return (Hash::_ObjectsEqual(this->nodeClass, v.nodeClass) && Hash::_ObjectsEqual(this->identifier, v.identifier));
        }
    };
}
typedef VZ::_StateScopeKey VZStateScopeKey;
namespace std
{
    template <>
    struct hash<VZStateScopeKey>
    {
        size_t operator ()(VZStateScopeKey k) const {
            NSUInteger subhashes[] = { [k.nodeClass hash], [k.identifier hash] };
            
            NSUInteger count = sizeof(subhashes)/sizeof(subhashes[0]);
            return VZ::Hash::IntegerArrayHash(subhashes, count);
        }
    };
    
    
   // NSString*
    
}

@implementation VZFScopeFrame{
    
    NSMutableDictionary* _children;
//    std::unordered_map<VZStateScopeKey, VZFScopeFrame *> _children;

}


- (id)initWithScopeHandler:(VZFScopeHandler *)scopeHandler{

    self = [super init];
    if (self) {
        _handler = scopeHandler;
        _children = [NSMutableDictionary new];
    }
    return self;
}
+ (VZScopeFramePair)scopeFramePair:(const VZScopeFramePair& )pair
                              NewRoot:(VZFRootScope* )newRoot
                            NodeClass:(Class )nodeClz
                           Identifier:(id)identifier
                  InitialStateCreator:(id (^)())initialStateCreator
                         StateUpdates:(NSDictionary* )stateUpdatesFunc{


    // Find the existing child, if any, in the old frame
    VZFScopeFrame *existingChild = nil;;
    if (pair.oldScopeFrame) {
        
        NSMutableDictionary* oldFrameChildren = pair.oldScopeFrame->_children;
        NSString* key = VZ::Hash::ScopeHashKey(nodeClz, identifier);
        VZFScopeFrame* value = [oldFrameChildren objectForKey:key];
        if (value) {
            existingChild = value;
        }
//        const auto it = oldFrameChildren.find({nodeClz, identifier});
//        if (it != oldFrameChildren.end() ) {
//            existingChild = it -> second;
//        }
    }
    
    VZFScopeHandler* newHandler = nil;
    if (existingChild) {
        newHandler = [existingChild.handler newHandlerWithLatestState:stateUpdatesFunc];
    }
    else{
        newHandler = [[VZFScopeHandler alloc]initWithListener:newRoot.listener
                                          RootScopeIdentifier:@(newRoot.rootScopeId)
                                                    NodeClass:nodeClz
                                             InitialStateFunc:initialStateCreator];
    }
    
    
    //[newRoot registerAnnounceableEventsForController:newHandle.controller];
    
    
    VZFScopeFrame* newFrame = [[VZFScopeFrame alloc]initWithScopeHandler:newHandler];
    NSString* newKey = VZ::Hash::ScopeHashKey(nodeClz, identifier);
    if ([[pair.newScopeFrame->_children allKeys] containsObject:newKey]) {
        //assert
        NSAssert(false, @"Scope collision: attempting to create duplicate scope %@:%@", nodeClz, identifier);
    }
    else{
        [pair.newScopeFrame->_children setObject:newFrame forKey:newKey];
    }
    
    
//    const auto result = pair.newScopeFrame->_children.insert({{nodeClz, identifier}, newFrame});
  //  CKAssert(result.second, @"Scope collision: attempting to create duplicate scope %@:%@", componentClass, identifier);
    return {.newScopeFrame = newFrame, .oldScopeFrame = existingChild};


}

- (NSString* )description{
    
    return [NSString stringWithFormat:@"%@ -> {\n handler:%@\n children:%@\n}",[self class],_handler,_children];
    
}

@end
