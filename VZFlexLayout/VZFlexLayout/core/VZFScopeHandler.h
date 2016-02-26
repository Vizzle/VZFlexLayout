//
//  VZFScopeHandler.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFScope.h"
#import "VZFNodeController.h"
#import "VZFScopeManager.h"

@class VZFNode;
@interface VZFScopeHandler : NSObject<NSCopying>

@property(nonatomic,strong,readonly) VZFNodeController* controller;
@property(nonatomic,strong,readonly) id state;
@property(nonatomic,assign,readonly) BOOL isRootHandler;

+ (VZFScopeHandler* )scopeHandlerForNode:(VZFNode* )node;

- (instancetype)initWithListener:(id<VZFStateListener>)listener
             RootScopeIdentifier:(id)identifier
                       NodeClass:(Class )nodeClass
                InitialStateFunc:(id(^)(void))stateFunc;

- (instancetype)newHandler;
- (instancetype)newHandlerWithLatestState:(NSDictionary* )multiStates;

- (BOOL)bindToNode:(VZFNode* )node;

- (void)updateState:(id(^)(id))stateBlock;



@end
