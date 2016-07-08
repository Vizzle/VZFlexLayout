//
//  FBScrollNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBScrollNode.h"
#import "FBHostItem.h"
#import "VZFScrollNode.h"
#import "VZFScrollNodeSpecs.h"
#import "VZFNodeSpecs.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFStackNode.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"
#import "FBScrollChildNode.h"
#import "VZFNodeSubClass.h"



@implementation FBScrollNode

+ (instancetype)newWithProps:(FBHostItem* )item Store:(id)store Context:(NSIndexPath* )indexpath{

    
    std::vector<VZFNode* > childs{};
    for (int i=0;i<item.cards.count; i++) {
        FBScrollChildNode* childNode = [FBScrollChildNode newWithScrollItem:item.cards[i] Index:i];
        childs.push_back(childNode);
    }
    
    VZFScrollNode* scrollNode = [VZFScrollNode newWithScrollAttributes:{
        .scrollDirection = VZ::ScrollDirection::ScrollHorizontal,
        .paging = true,
    } StackAttributes:{
        .spacing = 10
    
    } NodeSpecs:{
        .flex = {
            .height = 180,
            .marginTop = 5,
            .marginBottom = 5,
        },
        .view = {
            .clip = YES,
        }
    } Children:childs];

    
    return [super newWithNode:scrollNode];
}


@end
