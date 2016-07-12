//
//  VZFNodeThreadLocalScope.h
//  O2OReact
//
//  Created by moxin on 16/5/11.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFScopeFrame.h"
#import <stack>

@class VZFRootScope;
class VZFThreadLocalScope{

public:
    VZFThreadLocalScope(VZFRootScope* previouseRootScope, NSDictionary* stateUpdateFuncs);
    ~VZFThreadLocalScope();
    static VZFThreadLocalScope* currentScope();
    
    VZFRootScope* const newScopeRoot;
    NSDictionary* stateUpdateFunc;
    std::stack<ScopeFramePair> stack;


};