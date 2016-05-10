//
//  FBScrollNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBScrollNode.h"
#import "FBHostItem.h"
#import "VZFScrollNode.h"
#import "VZFScrollNodeSpecs.h"
#import "VZFNodeSpecs.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFStackNode.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"

@implementation FBScrollNode

+ (instancetype)newWithItem:(FBHostItem *)item{

    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
    
        .flex = {
            .height = 200
        }
    
    } Children:{
    
        { [VZFScrollNode newWithScrollAttributes:{
            .direction = VZ::ScrollDirection::Horizontal,
            .paging = true,
            .spacing = 10
            
        } NodeSpecs:{
            .flex = {
                .flexGrow = 1,
                .margin = 20
            },
            .view = {
                .clip = YES,
            }
            
            
        } Children:{
            
            {[VZFImageNode newWithImageAttributes:{
                .imageUrl = item.images[0],
                
                
            } NodeSpecs:{
                .view = {.backgroundColor = [UIColor redColor]},
                .flex = {
                    .width = 100,
                }
                
            }]},
            {
                [VZFStackNode newWithStackSpecs:{
                    .flex=  {
                        .width = 100,
                        .stackLayout = {.direction = VZFlexVertical},
                    }
                
                } Children:{
                    
                    {[VZFImageNode newWithImageAttributes:{
                        
                    } NodeSpecs:{
                        .view = {.backgroundColor = [UIColor cyanColor]},
                        .flex = {
                            .width = 80,
                            .height = 80,
                            .marginTop = 10,
                            .marginLeft = 10,
                            .marginRight = 10,
                        }
                    }]},
                    
                    {
                        [VZFTextNode newWithNodeSpecs:{
                            
                            .flex = {
                                .marginTop = 10
                            }
                            
                        } TextAttributes:{
                            
                            .text = item.nick,
                            .fontSize = 14
                        
                        }],
                    }
                
                
                
                }]
            
            },
            {[VZFImageNode newWithImageAttributes:{
                .imageUrl = item.images[2],
                
            } NodeSpecs:{
                .view = {.backgroundColor = [UIColor grayColor]},
                .flex = {
                    .width = 100,
                }
                
            }]},
            
            {[VZFImageNode newWithImageAttributes:{
                
                .imageUrl = item.images[3],
                
            } NodeSpecs:{
                .view = {.backgroundColor = [UIColor greenColor]},
                .flex = {
                    .width = 100,
                }
                
            }]},
            
        }]}
    
    }];
    
    return [super newWithNode:stackNode];
}

@end
