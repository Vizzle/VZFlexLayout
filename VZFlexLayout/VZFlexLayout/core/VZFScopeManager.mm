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
#include <string>


@implementation VZFLocalScope
{
    VZFRootScope* _newRootScope;
    NSDictionary* _funcs;
    std::stack<VZScopeFramePair> _stack;

}

- (VZFRootScope* )newRootScope{
    return _newRootScope;
}

- (NSDictionary* )stateUpdateFunctions{
    return _funcs;
}

- (id)initWithRootScope:(VZFRootScope *)rootScope StateUpdates:(NSDictionary *)funcs{

    self = [super init];
    if (self) {
        _newRootScope = [rootScope newRootScope];
        _funcs = funcs;
        _stack.push({[_newRootScope rootFrame],[rootScope rootFrame]});
        
    }
    return self;
}

- (void)pop{
    
    return _stack.pop();

}

- (VZScopeFramePair)top{
    return _stack.top();
}
- (void)push:(const VZScopeFramePair& )pair{

    _stack.push(pair);
}

- (void)dealloc{
    _stack.pop();

}

- (NSString* )description{

    NSString* stackDesc=@"";
    
    std::string str("");
    for (std::stack<VZScopeFramePair> dump = _stack; !dump.empty(); dump.pop()){
        str += [NSString stringWithFormat:@"{new:%@,old:%@},",dump.top().newScopeFrame,dump.top().oldScopeFrame].UTF8String;
    }
    stackDesc = [[NSString alloc]initWithCString:str.c_str() encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@-->\n{\n RootScope:%@ \n Functions:%@\n Stack:%@\n}",self.class,_newRootScope,_funcs,stackDesc];


}

@end




@implementation VZFScopeManager
{


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

    }
    return self;
}

+ (VZBuildNodeResult)buildNodeWithFunction:(VZFNode*(^)(void))function
                                 RootScope:(VZFRootScope* )rootScope
                          StateUpdateFuncs:(NSDictionary* )funcs{


    VZFLocalScope* localScope = [VZFScopeManager newLocalScopeWithRootScope:rootScope StateUpdateFuncs:funcs];
    VZFNode* node = function();
    return {.node = node, .scopeRoot = localScope.newRootScope};
    
}
+ (VZFLocalScope* )newLocalScopeWithRootScope:(VZFRootScope* )rootScope StateUpdateFuncs:(NSDictionary* )funcs{

    VZFLocalScope* localScope = [[VZFLocalScope alloc]initWithRootScope:rootScope StateUpdates:funcs];
    [VZFScopeManager sharedInstance] -> _currentLocalScope = localScope;
    return localScope;

}


@end
