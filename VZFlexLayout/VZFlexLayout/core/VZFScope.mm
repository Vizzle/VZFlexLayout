
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
#import "VZFScopeFrame.h"
#import "VZFMacros.h"


namespace VZ {
    
    Scope::Scope(Class clz, id scopeIdentifier, id(^initialStateCreator)(void)):_scopeIdentifier(scopeIdentifier),_nodeClass(clz){

        
        _threadLocalScope = VZFThreadLocalScope::currentScope();
        if (_threadLocalScope != nullptr) {
            
            const auto currentPair = _threadLocalScope->stack.top();
            
            const auto newPair = [VZFScopeFrame scopeFramePair:currentPair
                                                    NewRoot:_threadLocalScope->newScopeRoot
                                                  NodeClass:clz
                                                 Identifier:scopeIdentifier
                                        InitialStateCreator:initialStateCreator
                                               StateUpdates:_threadLocalScope->stateUpdateFunc];
            
//            [localScope push:newPair];
            _threadLocalScope -> stack.push({.newScopeFrame = newPair.newScopeFrame,.oldScopeFrame = newPair.oldScopeFrame});
            _state = newPair.newScopeFrame.handler.state;
        }
        else{
        
            //assert here
            VZFCAssertNil(true, @"scope为空！");
        }

    };
    
    Scope::~Scope(){
        
//        VZFLocalScope* localScope = [VZFScopeManager sharedInstance].currentLocalScope;
//        if (localScope) {
//            [localScope pop];
//        }
        if (_threadLocalScope != nullptr) {
            _threadLocalScope->stack.pop();
        }
        
    }
    
    id Scope::state() const {
        return _state;
    }
    
}

