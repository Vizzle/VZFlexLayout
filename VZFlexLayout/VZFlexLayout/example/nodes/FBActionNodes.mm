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
}


+ (instancetype)newWithProps:(FBHostItem* )item Store:(FBContentNodeStore* )store Context:(NSIndexPath* )indexpath{
    
    NSDictionary* state = [store initialStateAtIndex:indexpath.row];
    BOOL isLike = [state[@"like"] boolValue];
    BOOL isRewarded = [state[@"reward"] boolValue];
    NSDictionary* likeProps = isLike?@{@"image":[UIImage imageNamed:@"comment_liked"],@"text":item.likeCount,@"type":@"like"}:@{@"image":[UIImage imageNamed:@"comment_like"],@"text":item.likeCount,@"type":@"like"};
    NSDictionary* rewardProps = isRewarded?@{@"image":[UIImage imageNamed:@"comment_rewarded"],@"text":item.rewardCount,@"type":@"reward"}:@{@"image":[UIImage imageNamed:@"comment_reward"],@"text":item.rewardCount,@"type":@"reward"};
    
    VZFStackNode* actions = [VZFStackNode newWithStackAttributes:{
        .spacing = 5
    } NodeSpecs:{
        .alignSelf = VZFlexEnd,
        .marginTop = 10,

    } Children:{
        
        {
            [FBClickNode newWithProps:likeProps
                                Store:store
                              Context:indexpath]
        },
        {
            [FBClickNode newWithProps:rewardProps
                                Store:store
                              Context:indexpath]
        }
    }];
    return  [super newWithNode:actions];
    
}



@end
