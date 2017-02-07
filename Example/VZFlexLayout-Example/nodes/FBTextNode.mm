//
//  FBTextNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBTextNode.h"
#import <VZFlexLayout/VZFlexLayout.h>
#import "FBLocationNode.h"
#import "FBHostItem.h"


@implementation FBTextNode

+ (instancetype)newWithItem:(FBHostItem* )item{

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical,
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        {[VZFTextNode newWithTextAttributes:{
            .text = item.content,
            .fontName = @"Helvetica Neue",
            .fontSize = 14,
            .lines = 0
        } NodeSpecs:{}]},
        {item.location?[FBLocationNode newWithLocation:item.location]:nil}
    }];
    
    return [super newWithNode:stackNode];
}


@end
