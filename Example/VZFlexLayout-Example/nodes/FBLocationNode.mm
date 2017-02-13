//
//  FBLocationNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBLocationNode.h"
#import <VZFlexLayout/VZFlexLayout.h>

@implementation FBLocationNode

+ (instancetype)newWithLocation:(NSString* )location{

    
    VZFStackNode* node = [VZFStackNode newWithStackAttributes:{
        .spacing = 10
    }NodeSpecs:{

            .backgroundColor = [UIColor lightGrayColor],


            .marginTop = 10,


    } Children:{
    
        {
            [VZFImageNode newWithImageAttributes:{.image = [UIImage imageNamed:@"comment_location"]}
                                       NodeSpecs:{
                                           
                                           
                                               .marginLeft = 5,
                                               .marginTop = 10,
                                               .marginBottom = 10,
                                           
                                           
                                       }]
            
        },
        {[VZFTextNode newWithTextAttributes:{
            .text = location,
            .fontSize = 14.0f,
            .color = [UIColor blackColor]
        }NodeSpecs:{}]}
        
    }];
    
    return [super newWithNode:node];
}

@end
