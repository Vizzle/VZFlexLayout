//
//  VZFRootScope.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/25.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFScopeManager.h"

@class VZFScopeFrame;
@interface VZFRootScope : NSObject

@property(nonatomic,strong,readonly) VZFScopeFrame* rootFrame;
@property(nonatomic,weak,readonly) id<VZFStateListener> listener;
@property(nonatomic,assign,readonly) int32_t rootScopeId;
/**
 * 每个root scope绑定一个listener
 *
 *  @param listener node的state变化触发这个listener
 *
 *  @return scope
 */
+ (instancetype)rootScopeWithListener:(id<VZFStateListener>)listener;
- (instancetype)newRootScope;



@end
