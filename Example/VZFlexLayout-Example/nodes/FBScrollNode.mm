//
//  FBScrollNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBScrollNode.h"
#import "FBHostItem.h"
#import "FBScrollChildNode.h"
#import <VZFlexLayout/VZFlexLayout.h>



@implementation FBScrollNode

+ (instancetype)newWithProps:(FBHostItem* )item Store:(id)store Context:(NSIndexPath* )indexpath{

    
    std::vector<VZFNode* > childs{};
    for (int i=0;i<item.cards.count; i++) {
        FBScrollChildNode* childNode = [FBScrollChildNode newWithProps:item.cards[i] Store:store Context:@(i)];
        childs.push_back(childNode);
    }
    
    VZFScrollNode* scrollNode = [VZFScrollNode newWithScrollAttributes:{
        .scrollDirection = VZ::ScrollDirection::ScrollHorizontal,
        .paging = true,
    } StackAttributes:{
        .spacing = 10
    
    } NodeSpecs:{

        .height = 180,
        .marginTop = 5,
        .marginBottom = 5,
        .clip = YES,

    } Children:childs];

    
    return [super newWithNode:scrollNode];
}




@end
