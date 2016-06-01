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

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .justifyContent = VZFlexSpaceBetween
    } NodeSpecs:{
        
    } Children:{
        {[VZFTextNode newWithTextAttributes:{
            .text = name,
            .color = [UIColor blackColor],
            .fontSize = 14.0f,
        } NodeSpecs:{.view = {.backgroundColor = [UIColor clearColor]}}]},
        {
            [VZFTextNode newWithTextAttributes:{
                
                .text = time,
                .color = [UIColor lightGrayColor],
                .fontSize = 12.0f,
                .alignment = NSTextAlignmentRight
                
            }NodeSpecs:{
                .view = {.backgroundColor = [UIColor clearColor]}
            } ]

        }
    
    }];
    
    return [super newWithNode:stackNode];

}


@end
