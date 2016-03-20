//
//  FBHeadNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNode.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFStackNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFNetworkImageNode.h"
#import "VZFScope.h"
#import "FBImageDownloader.h"
#import "VZFImageNode.h"
#import "FBHostItem.h"
#import "FBGridImageNode.h"
#import "VZFLineNode.h"
#import "FBActionNode.h"

@implementation FBContentNode


+ (id)initialState{

    return @{
                @"expend":@(NO),
                @"like":@(NO),
                @"reward":@(NO)
             
             };
}

+ (instancetype)newWithItem:(FBHostItem *)item
{
    VZ::Scope scope(self);
    NSDictionary* state = scope.state();

    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{} TextAttributes:{
        
        .text = item.content,
        .font = [UIFont systemFontOfSize:14.0f],
        .maximumNumberOfLines = [state[@"expend"] boolValue] ? 0UL : 4UL
    
    }];
    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithNodeSpecs:{
    
        .flex = {.alignSelf = VZFlexStart,.marginTop = 5}
    
    } ButtonAttributes:{
        
        .title = [state[@"expend"] boolValue] ? @"收起":@"展开",
        .titleColor = [UIColor redColor],
        .font = [UIFont systemFontOfSize:14.0f],
//        .action = ^(id sender){

//        }
        .action = @selector(onExpendClicked:),
    }];
    
    FBGridImageNode* imageNode = [FBGridImageNode newWithImageURLs:item.images];

    
    VZFStackNode* location = [VZFStackNode newWithStackSpecs:{
    
        .view = {
            .backgroundColor = [UIColor lightGrayColor]
        },
        .flex= {
            .marginTop = 10,
            .stackLayout = {.spacing = 10}
        }
    } Children:{
    
        {[VZFImageNode newWithNodeSpecs:{
            .flex = {
                .marginLeft = 5,
                .marginTop = 10,
                .marginBottom = 10,
            }
        } ImageAttributes:{.image = [UIImage imageNamed:@"comment_location"]}]},
        {[VZFTextNode newWithNodeSpecs:{} TextAttributes:{.text = item.location, .font = [UIFont systemFontOfSize:14.0f], .color = [UIColor blackColor]}]}
    
    }];
    
    
    VZFStackNode* actions = [VZFStackNode newWithStackSpecs:{
        .flex = {
            .alignSelf = VZFlexEnd,
            .marginTop = 10,
            .stackLayout = {.spacing = 5}
        }
    
    } Children:{
        { [FBActionNode newWithImage:[item.isLike boolValue]?[UIImage imageNamed:@"comment_liked"]:[UIImage imageNamed:@"comment_like"] Text:item.likeCount Action:@selector(onLikeClicked:)]},
        { [FBActionNode newWithImage:[item.isReward boolValue]?[UIImage imageNamed:@"comment_rewarded"]:[UIImage imageNamed:@"comment_reward"] Text:item.rewardCount Action:@selector(onRewardClicked:)]},
//        { [FBActionNode newWithImage:[UIImage imageNamed:@"comment_liked"] Text:item.likeCount Action:@selector(onLikeClicked:)]}
        
    
    }];
    
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .flex = {
            .marginLeft = 40,
            .stackLayout = { .direction = VZFlexVertical }
        }
    
    } Children:{
    
        {.node = item.content?textNode:nil},
        {.node = item.content?buttonNode:nil},
        {.node = item.images.count > 0 ?imageNode:nil},
        {.node = item.location?location:nil},
        {.node = actions}
    
    }];
    
    FBContentNode* headNode =  [super newWithNode:stackNode];

    return headNode;
}

- (void)onLikeClicked:(id)sender{

    [self updateState:^id(NSDictionary* oldState) {
        
        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"like"] = @(![oldState[@"like"] boolValue]);
        return [mutableOldState copy];
        
    }];

    
//    [self.nextResponder performSelector:@selector(onLikeClicked:) withObject:nil ];
}

- (void)onRewardClicked:(id)sender{


}


- (void)onExpendClicked:(id)sender {

    [self updateState:^id(NSDictionary* oldState) {
        
        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"expend"] = @(![oldState[@"expend"] boolValue]);
        return [mutableOldState copy];
    }];
}

@end
