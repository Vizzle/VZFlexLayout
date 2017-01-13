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
#import "FBSampleActionType.h"

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
                        .actionType = left,
                        .dispatcher = store.dispatcher,
                    });
                }],
                .isAccessibilityElement = YES,
                .accessibilityLabel = @"LEFT BUTTON"
                
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
                        .actionType = right,
                        .dispatcher = store.dispatcher,
                    });
                }],
                .isAccessibilityElement = YES,
                .accessibilityLabel = @"RIGHT BUTTON"
                
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
