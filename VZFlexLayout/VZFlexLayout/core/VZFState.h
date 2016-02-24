//
//  VZFState.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VZFStateListener <NSObject>

@optional
- (void)nodeStateUpdateWithScopeId:(int32_t)scopeId rootScopeId:(int32_t)rootScopeId Func:(id(^)(id))updateFunc;

@end

typedef id(^stateTrampolineBlock)(id);
@protocol VZFProps <NSObject>
- (id)value;
- (stateTrampolineBlock)stateTrampolineBlock;
@end

@interface VZFState : NSObject

@end
