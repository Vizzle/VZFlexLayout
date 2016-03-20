//
//  FBLocationNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBLocationNode.h"
#import "VZFStackNode.h"
#import "VZFImageNode.h"
#import "VZFTextNode.h"

@implementation FBLocationNode

+ (instancetype)newWithLocation:(NSString* )location{

    VZFStackNode* node = [VZFStackNode newWithStackSpecs:{
        
        .view = {
            .backgroundColor = [UIColor lightGrayColor]
        },
        .flex= {
            .marginTop = 10,
            .stackLayout = {.spacing = 10}
        }
    } Children:{
        
        {[VZFImageNode newWithNodeSpecs:{
            .flex = {
                .marginLeft = 5,
                .marginTop = 10,
                .marginBottom = 10,
            }
        } ImageAttributes:{.image = [UIImage imageNamed:@"comment_location"]}]},
        {[VZFTextNode newWithNodeSpecs:{}
                        TextAttributes:{.text = location,
                            .font = [UIFont systemFontOfSize:14.0f],
                            .color = [UIColor blackColor]}]}
        
    }];
    
    return [super newWithNode:node];
}

@end
