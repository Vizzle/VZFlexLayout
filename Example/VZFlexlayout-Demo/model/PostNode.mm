//
//  PostNode.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostNode.h"
#import <VZFlexLayout/VZFStackNode.h>
#import <VZFlexLayout/VZFTextNode.h>
#import "PostItem.h"
@implementation PostNode

+ (id)newWithProps:(PostItem* )props Store:(VZFluxStore *)store Context:(id)ctx{
    
    return [PostNode newWithNode:
            [VZFStackNode newWithStackAttributes:{.direction = VZFlexVertical}
                                       NodeSpecs:{}
                                        Children:{
                                                     {[VZFTextNode newWithTextAttributes:{
                                                         .text = props.title,
                                                         .color = [UIColor blackColor],
                                                         .fontSize = 16,
                                                         .fontStyle= VZFFontStyleBold,
                                                         .lines = 0
                                                     } NodeSpecs:{
                                                         .marginLeft = 12,
                                                         .marginTop = 10
                                                     }]},
                                                     {[VZFTextNode newWithTextAttributes:{
                                                         .text = props.body,
                                                         .color = [UIColor darkGrayColor],
                                                         .fontSize = 12,
                                                         .fontStyle= VZFFontStyleNormal,
                                                         .lines = 0
                                                     } NodeSpecs:{
                                                         .marginLeft = 12,
                                                         .marginTop = 10,
                                                         .marginBottom = 10
                                                     }]}
                                                 }]
            ];
}

@end
