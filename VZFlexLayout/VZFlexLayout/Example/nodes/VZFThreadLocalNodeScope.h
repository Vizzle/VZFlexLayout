//
//  VZFThreadLocalNodeScope.h
//  VZFlexLayout
//
//  Created by moxin on 16/5/10.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stack>
#import "VZFScopeFrame.h"


class VZFThreadLocalNodeScope{
    
public:
    VZFThreadLocalNodeScope(VZFRootScope* previouseRootScope, NSDictionary* stateUpdateFuncs);
    ~VZFThreadLocalNodeScope();
    static VZFThreadLocalNodeScope* currentScope();
    
    VZFRootScope* const newScopeRoot;
    NSDictionary* stateUpdateFunc;
    std::stack<ScopeFramePair> stack;
};
