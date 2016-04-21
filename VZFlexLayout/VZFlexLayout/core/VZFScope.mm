
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
#import "VZFScopeFrame.h"
#import "VZFMacros.h"

namespace VZ {
    
    Scope::Scope(Class clz, id scopeIdentifier, id(^initialStateCreator)(void)):_scopeIdentifier(scopeIdentifier),_nodeClass(clz){

        
        VZFLocalScope* localScope = [VZFScopeManager sharedInstance].currentLocalScope;
        if (localScope) {
            
            const auto currentPair = [localScope top];
            
            const auto newPair = [VZFScopeFrame scopeFramePair:currentPair
                                                    NewRoot:[localScope newRootScope]
                                                  NodeClass:clz
                                                 Identifier:scopeIdentifier
                                        InitialStateCreator:initialStateCreator
                                               StateUpdates:[localScope stateUpdateFunctions]];
            
            [localScope push:newPair];
            _state = newPair.newScopeFrame.handler.state;
        }
//        else{
//        
//            //assert here
//            VZFCAssertNil(true, @"local scope is nil!");
//        }

    };
    
    Scope::~Scope(){
        
        VZFLocalScope* localScope = [VZFScopeManager sharedInstance].currentLocalScope;
        if (localScope) {
            [localScope pop];
        }
        
    }
    
    id Scope::state() const {
        return _state;
    }
    
}

