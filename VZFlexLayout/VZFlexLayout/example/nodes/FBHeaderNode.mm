//
//  FBHeaderNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHeaderNode.h"
#import "FBNameNode.h"
#import "FBStarNode.h"
#import "VZFStackNode.h"
#import "FBHostItem.h"

@implementation FBHeaderNode

+ (instancetype)newWithItem:(FBHostItem* )item{

    VZFStackNode* righStackNode = [VZFStackNode newWithStackSpecs:{
        .flex = {.stackLayout = {.direction = VZFlexVertical }}
    
    } Children:{
        {[FBNameNode newWithName:item.nick createTime:item.time]},
        {[FBStarNode newWithScore:[item.score floatValue]]}
    }];

    return [super newWithNode:righStackNode];

}


@end
