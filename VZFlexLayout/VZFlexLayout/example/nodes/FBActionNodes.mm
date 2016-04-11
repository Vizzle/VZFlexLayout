//
//  FBActionNodes.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBActionNodes.h"
#import "FBClickNode.h"
#import "VZFStackNode.h"
#import "VZFScope.h"
#import "FBHostItem.h"
#import "VZFNodeInternal.h"

@implementation FBActionNodes


+ (id)initialState{
    
    return @{@"like":@(NO),@"reward":@(NO)};
}
+ (instancetype)newWithItem:(FBHostItem* )item{
    
    
    
    VZ::Scope scope(self);
    NSDictionary* state = scope.state();
    BOOL isLike = [state[@"like"] boolValue];
    BOOL isRewarded = [state[@"reward"] boolValue];
    
    VZFStackNode* actions = [VZFStackNode newWithStackSpecs:{
        .flex = {
            .alignSelf = VZFlexEnd,
            .marginTop = 10,
            .stackLayout = {.spacing = 5}
        }
        
    } Children:{
        { [FBClickNode newWithImage:isLike?[UIImage imageNamed:@"comment_liked"]:[UIImage imageNamed:@"comment_like"]
                               Text:item.likeCount
                             Action:@selector(onLikeClicked:)]
           },
        
        
        { [FBClickNode newWithImage:isRewarded?[UIImage imageNamed:@"comment_rewarded"]:[UIImage imageNamed:@"comment_reward"]
                               Text:item.rewardCount
                             Action:@selector(onRewardClicked:)]
        },
    }];
    
    return  [super newWithNode:actions];

}


- (void)onLikeClicked:(id)sender{
    
    [self updateState:^id(NSDictionary* oldState) {

        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"like"] = @(![oldState[@"like"] boolValue]);
        return [mutableOldState copy];

    }];
}

- (void)onRewardClicked:(id)sender{
    
    [self updateState:^id(NSDictionary* oldState) {

        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"reward"] = @(![oldState[@"reward"] boolValue]);
        return [mutableOldState copy];

    }];
}

@end
