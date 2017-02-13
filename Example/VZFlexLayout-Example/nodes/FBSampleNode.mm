//
//  FBSampleNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/7/12.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBSampleNode.h"
#import <VZFlexLayout/VZFStackNode.h>
#import "FBScrollNode.h"

@implementation FBSampleNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx{
    
    FBScrollNode* scrollNode = [FBScrollNode newWithProps:props Store:store Context:ctx];
    return [super newWithNode:scrollNode];
}

@end
