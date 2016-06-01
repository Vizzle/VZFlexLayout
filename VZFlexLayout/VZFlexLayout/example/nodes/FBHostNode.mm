//
//  FBHostNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHostNode.h"
#import "FBHeaderNode.h"
#import "FBContentNode.h"
#import "VZFStackNode.h"
#import "FBHostItem.h"
#import "VZFNodeSpecs.h"

@implementation FBHostNode

+ (instancetype)newWithItem:(FBHostItem* )item{

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical
    } NodeSpecs:{
        .flex = {.padding = 10}
    } Children:{
    
        {[FBHeaderNode newWithItem:item]},
        {[FBContentNode newWithItem:item]},
    }];
    
    return [super newWithNode:stackNode];
}



@end
