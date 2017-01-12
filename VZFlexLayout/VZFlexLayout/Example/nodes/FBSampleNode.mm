//
//  FBSampleNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/7/12.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBSampleNode.h"
#import "VZFStackNode.h"
#import "FBScrollNode.h"
#import "VZFlux.h"
#import "VZFTextNode.h"

@implementation FBSampleNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx{
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        
        .alignItems = VZFlexCenter,
        .spacing = 15,
        .justifyContent = VZFlexCenter
        
    } NodeSpecs:{
        .paddingLeft = 15,
        .paddingRight = 25,
        .backgroundColor = [UIColor grayColor]
        
    } Children:{
        {
            [VZFStackNode newWithStackAttributes:{
                .justifyContent = VZFlexCenter
            } NodeSpecs:{
                .paddingLeft = 15,
                .paddingRight = 15,
                .height = 35,
                .width = 170,
                .flexGrow = 1,
                .borderColor = [UIColor whiteColor],
                .borderWidth = 1,
                .cornerRadius = 3,
                .backgroundColor = [UIColor yellowColor],
                .userInteractionEnabled = true,
                .gesture = [VZFBlockGesture tapGesture:^(id sender) {
                    FluxAction::send({
                        .source = view_action,
                        .dispatcher = store.dispatcher,
                    });
                }],
                .isAccessibilityElement = YES,
                .accessibilityLabel = @"abc"
                
            } Children:{
                
                {[VZFTextNode newWithTextAttributes:{
                    .text = @"左边Button",
                    .color = [UIColor redColor],
                    .fontSize = 18,
                    .alignment = NSTextAlignmentCenter,
                } NodeSpecs:{}]}

            }]
        },
        {
            
            [VZFStackNode newWithStackAttributes:{
                .justifyContent = VZFlexCenter
            } NodeSpecs:{
                .paddingLeft = 15,
                .paddingRight = 15,
                .height = 35,
                .width = 170,
                .flexGrow = 1,
                .borderColor = [UIColor whiteColor],
                .borderWidth = 1,
                .cornerRadius = 3,
                .backgroundColor = [UIColor redColor],
                .userInteractionEnabled = true,
                .gesture = [VZFBlockGesture tapGesture:^(id sender) {
                    FluxAction::send({
                        .source = view_action,
                        //                        .actionType = [shareState isEqualToString:O2OPassCanShare] ? O2O_SHARE_BUTTON_CLICKED : O2O_CNACEL_SHARE_BUTTON_CLICKED,
                        .dispatcher = store.dispatcher,
                    });
                }],
                .isAccessibilityElement = YES,
                .accessibilityLabel = @"abc"
                
            } Children:{
                
                {[VZFTextNode newWithTextAttributes:{
                    .text = @"右边Button",
                    .color = [UIColor yellowColor],
                    .fontSize = 18,
                    .alignment = NSTextAlignmentCenter,
                } NodeSpecs:{}]}
                
            }]
        
        
        }
        
    }];
    
    return [super newWithNode:stackNode];
}

@end
