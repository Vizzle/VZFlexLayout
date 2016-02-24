//
//  VZFScopeHandler.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFScope.h"

@class VZFNode;
@interface VZFScopeHandler : NSObject

@property(nonatomic,weak,readonly) id state;

- (instancetype)initWithListener:(id<VZFStateListener>)listener
                     rootScopeId:(int32_t)rootScopeId
                       Node:(VZFNode* )node
                       PropsFunc:(id(^)(void))propCreator;
/** Creates a new version of an existing scope handle that incorporates the given state updates */
- (instancetype)newHandleWithStateUpdates:(const VZFNodeStateUpdateMap &)stateUpdates;

- (void)updateState:(id(^)(id))stateBlock;

@end
