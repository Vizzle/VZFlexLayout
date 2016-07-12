//
//  VZFScopeManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFScopeManager.h"
#import "VZFScopeHandler.h"
#import "VZFRootScope.h"
#import "VZFScopeFrame.h"
#import "VZFThreadLocalScope.h"
#include <stack>
#include <string>


using namespace VZ;

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

+ (VZFBuildNodeResult)buildNodeWithFunction:(VZFNode*(^)(void))function
                                 RootScope:(VZFRootScope* )rootScope
                          StateUpdateFuncs:(NSDictionary* )funcs{

    VZFThreadLocalScope localScope = VZFThreadLocalScope(rootScope,funcs);
    VZFNode* node = function();
    
    return {.node = node, .scopeRoot = localScope.newScopeRoot};
    
}
@end
