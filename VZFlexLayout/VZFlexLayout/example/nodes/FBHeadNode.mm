//
//  FBHeadNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHeadNode.h"
#import "VZFNode.h"

@implementation FBHeadNode


+ (instancetype)new{

    VZFNode* node = [VZFNode newWithView:[UIView class] NodeSpecs:{
        
        .view = {
        
            .backgroundColor = [UIColor blackColor],
            .layer = {
            
            
            },
        },
        .flex = {
            .width = 100,
            .height = 100,
        }
    
    
    }];
    
    FBHeadNode* headNode = [super newWithNode:node Props:nil];
    
    return headNode;

}


@end
