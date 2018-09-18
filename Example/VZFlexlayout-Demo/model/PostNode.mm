//
//  PostNode.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostNode.h"
#import "PostItem.h"

@implementation PostNode

+ (id)newWithProps:(PostItem* )props Store:(VZFluxStore *)store Context:(id)ctx{
    
    return [PostNode newWithNode:
            [VZFStackNode newWithStackAttributes:{.direction = VZFlexVertical, .justifyContent = VZFlexStart}
                                       NodeSpecs:{.margin = 12}
                                        Children:{
                                                     {[VZFTextNode newWithTextAttributes:{
                                                         .text = props.title,
                                                         .color = [UIColor blackColor],
                                                         .fontSize = 16,
                                                         .fontStyle= VZFFontStyleBold,
                                                         .lineBreakMode = VZFTextLineBreakByWord,
                                                         .lines = 0
                                                     } NodeSpecs:{}]},
                                                     {[VZFTextNode newWithTextAttributes:{
                                                         .text = props.body,
                                                         .color = [UIColor darkGrayColor],
                                                         .fontSize = 12,
                                                         .fontStyle= VZFFontStyleNormal,
                                                         .lines = 0
                                                     } NodeSpecs:{.marginTop = 10,}]}
                                                 }]
            ];
}

@end
