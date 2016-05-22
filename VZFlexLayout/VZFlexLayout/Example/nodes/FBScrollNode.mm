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


+ (instancetype)newWithItem:(FBHostItem *)item{
    
    std::vector<VZFNode* > childs{};
    for (int i=0;i<item.cards.count; i++) {
        FBScrollChildNode* childNode = [FBScrollChildNode newWithDictionary:item.cards[i]];
        childs.push_back(childNode);
    }
    VZFScrollNode* scrollNode = [VZFScrollNode newWithScrollAttributes:{
        .scrollDirection = VZ::ScrollDirection::ScrollHorizontal,
        .paging = true,
        
    } NodeSpecs:{
        .flex = {
            .height = 180,
            .stackLayout = {.spacing = 10},
            .marginTop = 5,
            .marginBottom = 5,
        },
        .view = {
            .clip = YES,
        }
        
    } Children:childs];
    
    return [super newWithNode:scrollNode];
}

- (void)clicked:(id)sender{
    
//    [self updateState:^id(id oldState) {
//        
//        return oldState;
//    }];
}
@end
