//
//  VZFScopeManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFRootScope.h"
#import "VZFScopeFrame.h"


@class VZFNode;
@class VZFScopeHandler;

@interface VZFLocalScope:NSObject

- (id)initWithRootScope:(VZFRootScope* )rootScope StateUpdates:(NSDictionary* )funcs;
- (VZFRootScope* )newRootScope;
- (NSDictionary* )stateUpdateFunctions;
- (VZScopeFramePair )top;
- (void)pop;
- (void)push:(const VZScopeFramePair& )pair;

@end

struct VZBuildNodeResult {
    VZFNode *node;
    VZFRootScope *scopeRoot;
};

@interface VZFScopeManager : NSObject

@property(nonatomic,strong,readonly) VZFLocalScope* currentLocalScope;

+ (instancetype)sharedInstance;

/**
 *  构建node和RootScope
 *
 *  @param function  用来创建node
 *  @param rootScope HostingView持有的RootScope
 *  @param funcs     <id,NSArray<id(^state)(id)>>
 *
 *  @return node对象和新的RootScope
 */
+ (VZBuildNodeResult)buildNodeWithFunction:(VZFNode*(^)(void))function
                                 RootScope:(VZFRootScope* )rootScope
                          StateUpdateFuncs:(NSDictionary* )funcs;


@end
