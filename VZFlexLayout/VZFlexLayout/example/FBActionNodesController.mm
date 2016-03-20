//
//  FBActionsNodeController.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBActionNodesController.h"

@implementation FBActionNodesController


- (void)onLikeClicked:(id)sender{
    NSLog(@"like clicked");
}

- (void)onRewardClicked:(id)sender{
    NSLog(@"rewarded clicked");
}

- (void)dealloc{

    NSLog(@"[%@]-->dealloc",self.class);
}

@end
