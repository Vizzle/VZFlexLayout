//
//  VZFScopeManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stack>


@protocol VZFStateListener <NSObject>

@optional
/**
 *  node状态变化通过这个方法通知到HostingView
 *
 *  @param scopeId     发生状态变化的Node对应的ScopeId
 *  @param rootScopeId RootScopeId
 *  @param stateUpdate 更新状态的function
 */
- (void)nodeScopeHandleWithIdentifier:(id)scopeId
                       rootIdentifier:(id)rootScopeId
                didReceiveStateUpdate:(id (^)(id))stateUpdate;

@end


@class VZFNode;
@class VZFRootScope;
@class VZFScopeHandler;

namespace VZ {
    class ScopeFramePair;
}

using namespace VZ;
struct VZFBuildNodeResult {
    VZFNode *node;
    VZFRootScope *scopeRoot;
};

@interface VZFScopeManager : NSObject

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
+ (VZFBuildNodeResult)buildNodeWithFunction:(VZFNode*(^)(void))function
                                 RootScope:(VZFRootScope* )rootScope
                          StateUpdateFuncs:(NSDictionary* )funcs;



@end
