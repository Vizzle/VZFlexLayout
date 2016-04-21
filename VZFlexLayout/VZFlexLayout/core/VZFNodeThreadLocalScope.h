//
//  VZFNodeThreadLocalScope.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFScopeFrame.h"
#include <stack>


@class VZFRootScope;


/// 使用Objective-C版本的localScope
class VZFNodeThreadLocalScope{
public:
    VZFNodeThreadLocalScope(VZFRootScope* previousRootScope, NSDictionary* funcs);
    ~VZFNodeThreadLocalScope();
    
    static VZFNodeThreadLocalScope *currentScope();
    
    VZFRootScope*  newRootScope;
    const NSDictionary* stateUpdateFuncs;
    std::stack<ScopeFramePair> stack;
    
};
