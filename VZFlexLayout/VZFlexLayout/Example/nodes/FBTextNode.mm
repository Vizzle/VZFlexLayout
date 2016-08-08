//
//  FBTextNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBTextNode.h"
#import "VZFTextNode.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"
#import "FBHostItem.h"
#import "VZFStackNode.h"
#import "FBLocationNode.h"

@implementation FBTextNode

+ (instancetype)newWithItem:(FBHostItem* )item{

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical,
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        {[VZFTextNode newWithTextAttributes:{
            .text = item.content,
            .fontSize = 14,
            .lines = 0
        } NodeSpecs:{}]},
        {item.location?[FBLocationNode newWithLocation:item.location]:nil}
    }];
    
    return [super newWithNode:stackNode];
}


@end
