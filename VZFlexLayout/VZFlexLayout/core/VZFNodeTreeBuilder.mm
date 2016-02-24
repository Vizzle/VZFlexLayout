//
//  VZFNodeTreeBuilder.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/24.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeTreeBuilder.h"

@implementation VZFNodeTreeBuilder

+ (VZNodeTreeBuildResult)buildNodes:(VZFRootScope* )previousRootScope
                     StateUpdateMap:(const VZFNodeStateUpdateMap&) stateUpdateMap
                           NodeFunc:(VZFNode*(^)(void))func{
    
    VZFNode* node = func();
    
    return {
        .rootNode = node,
        .rootScope = previousRootScope
    };
}
@end
