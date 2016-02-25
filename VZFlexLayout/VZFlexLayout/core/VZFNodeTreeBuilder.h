//
//  VZFNodeTreeBuilder.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/24.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNode.h"
#import "VZFScope.h"


typedef struct {

    VZFNode* rootNode;
    VZFRootScope* rootScope;
    
}VZNodeTreeBuildResult;
@interface VZFNodeTreeBuilder : NSObject

+ (VZNodeTreeBuildResult)buildNodes:(VZFRootScope* )previousRootScope
                     StateUpdateMap:(const VZFNodeStateUpdateMap&) stateUpdateMap
                           NodeFunc:(VZFNode*(^)(void))func;

@end

@interface VZFNodeScopeBuilder : NSObject



@end
