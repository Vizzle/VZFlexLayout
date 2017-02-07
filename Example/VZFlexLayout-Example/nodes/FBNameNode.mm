//
//  FBNameNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBNameNode.h"
#import <VZFlexLayout/VZFlexLayout.h>

@implementation FBNameNode

+ (instancetype)newWithName:(NSString* )name createTime:(NSString* )time content:(NSString *)content{

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical
    } NodeSpecs:{
        
    } Children:{
        {[VZFStackNode newWithStackAttributes:{
            .justifyContent = VZFlexSpaceBetween
        } NodeSpecs:{
            
        } Children:{
            {[VZFTextNode newWithTextAttributes:{
                .text = name,
                .color = [UIColor blackColor],
                .fontSize = 14.0f,
                .alignment = NSTextAlignmentLeft
            } NodeSpecs:{}]},
            {
                [VZFTextNode newWithTextAttributes:{
                    
                    .text = time,
                    .color = [UIColor lightGrayColor],
                    .fontSize = 12.0f,
                    .alignment = NSTextAlignmentLeft
                    
                }NodeSpecs:{} ]
            }
            
        }]},
        {[VZFTextNode newWithTextAttributes:{
            .text = content,
            .color = [UIColor blackColor],
            .fontSize = 14.0f,
            .alignment = NSTextAlignmentLeft,
            .lines = 0
        } NodeSpecs:{}]}
        
    }];
    
    
    ;
    
    return [super newWithNode:stackNode];

}


@end
