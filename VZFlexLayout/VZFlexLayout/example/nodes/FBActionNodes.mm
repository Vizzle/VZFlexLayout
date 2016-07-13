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
#import "FBHostItem.h"
#import "VZFNodeInternal.h"
#import "VZFNodeSpecs.h"
#import "VZFlux.h"
#import "FBActionType.h"
#import "FBContentNodeStore.h"

@implementation FBActionNodes
{
    NSIndexPath* _indexPath;
    __weak FBContentNodeStore* _store;
}


+ (instancetype)newWithProps:(FBHostItem* )item Store:(FBContentNodeStore* )store Context:(NSIndexPath* )indexpath{
    
    NSDictionary* state = [store initialStateAtIndex:indexpath.row];
    BOOL isLike = [state[@"like"] boolValue];
    BOOL isRewarded = [state[@"reward"] boolValue];
    
    VZFStackNode* actions = [VZFStackNode newWithStackAttributes:{
        .spacing = 5
    } NodeSpecs:{
        .flex=  {
            .alignSelf = VZFlexEnd,
            .marginTop = 10,
        }
    } Children:{
        { [FBClickNode newWithImage:isLike?[UIImage imageNamed:@"comment_liked"]:[UIImage imageNamed:@"comment_like"]
                               Text:item.likeCount
                             Action:@selector(onLikeClicked:)]
        },
        
        
        { [FBClickNode newWithImage:isRewarded?[UIImage imageNamed:@"comment_rewarded"]:[UIImage imageNamed:@"comment_reward"]
                               Text:item.rewardCount
                             Action:@selector(onRewardClicked:)]
        }
    }];
    FBActionNodes* actionNode =  [super newWithNode:actions];
    actionNode -> _indexPath = indexpath;
    actionNode -> _store = store;
    return  actionNode;
    
}


- (void)onLikeClicked:(id)sender{
    
    FluxAction::send({
       
        .source = view_state,
        .actionType = LIKE_CLICKED_STATE,
        .payload = @{@"index":self->_indexPath?:[NSNull null]},
        .dispatcher = self ->_store.dispatcher,
    });
    
}

- (void)onRewardClicked:(id)sender{
    
    FluxAction::send ({
        
        .source = view_state,
        .actionType = REWARD_CLICKED_STATE,
        .payload = @{@"index":self->_indexPath?:[NSNull null]},
        .dispatcher = self->_store.dispatcher
        
    });
}

@end
