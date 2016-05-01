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
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"
#import "VZFImageNodeSpecs.h"
#import "VZFTextNodeSpecs.h"

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
        
        {
            [VZFImageNode newWithImageAttributes:{.image = [UIImage imageNamed:@"comment_location"]}
                                       NodeSpecs:{
                
                .flex = {
                    .marginLeft = 5,
                    .marginTop = 10,
                    .marginBottom = 10,
                }
            
            }]
        
        },
        {[VZFTextNode newWithNodeSpecs:{}
                        TextAttributes:{.text = location,
                            .fontSize = 14.0f,
                            .color = [UIColor blackColor]}]}
        
    }];
    
    return [super newWithNode:node];
}

@end
