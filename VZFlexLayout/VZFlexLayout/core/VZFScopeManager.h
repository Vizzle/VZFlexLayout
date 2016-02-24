//
//  VZFScopeManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/23.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VZFNode;
@class VZFScopeHandler;
@interface VZFScopeManager : NSObject

+ (instancetype)sharedInstance;

+ (VZFScopeHandler* )scopeHandlerForNode:(VZFNode* )node; //will mutate node

+ (VZFScopeHandler* )pushScopeHandlerWithScopeIdentifier:(id)identifier NodeClass:(Class)clz initialState:(id)state;
+ (void)popScopeHandler;

@end
