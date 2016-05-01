//
//  FBNameNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBNameNode.h"
#import "VZFStackNode.h"
#import "VZFTextNode.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"

@implementation FBNameNode

+ (instancetype)newWithName:(NSString* )name createTime:(NSString* )time{

    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        .flex = {
            .stackLayout = { .justifyContent = VZFlexSpaceBetween }
        }
    } Children:{
    
        {.node = [VZFTextNode newWithNodeSpecs:{.view = {.backgroundColor = [UIColor clearColor]}} TextAttributes:{
            .text = name,
            .color = [UIColor blackColor],
            .fontSize = 14.0f,
        }]},
        {
            .node = [VZFTextNode newWithNodeSpecs:{
                .view = {.backgroundColor = [UIColor clearColor]}
            } TextAttributes:{
            
                .text = time,
                .color = [UIColor lightGrayColor],
                .fontSize = 12.0f,
                .alignment = NSTextAlignmentRight
            
            }]
        }
    
    }];
    return [super newWithNode:stackNode];

}


@end
