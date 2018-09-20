//
//  PostNode.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostNode.h"
#import "PostItem.h"
#import "PostItemStore.h"
#import <string>

@implementation PostNode
+ (id)initialState{
    return nil;
}
+ (id)newWithProps:(PostItem* )props Store:(PostItemStore *)store Context:(id)ctx{

    NSDictionary* state = store.state;
    BOOL left = [state[@"left"] boolValue];
    return [PostNode newWithNode:
            [VZFStackNode newWithStackAttributes:{.direction = VZFlexVertical, .justifyContent = VZFlexStart}
                                       NodeSpecs:{.margin = 12,}
                                        Children:{
                                                     {[VZFTextNode newWithTextAttributes:{
                                                         .text = props.title,
                                                         .color = left?[UIColor orangeColor]:[UIColor blackColor],
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
                                                     } NodeSpecs:{.marginTop = 10,}]},
                                                     {
                                                         [VZFStackNode newWithStackAttributes:{.justifyContent=VZFlexStart}
                                                                                    NodeSpecs:{.marginTop = 10}
                                                                                     Children:{
                                                                                         {[[self class] LeftButtonNodeWithProps:props State:left FluxStore:store]},
                                                                                         {[[self class] RightButtonNodeWithProps:props FluxStore:store]}
                                                                                         
                                                         }]
                                                     }
                                                 }]
            ];
}

+ (VZFButtonNode* )LeftButtonNodeWithProps:(PostItem* )props State:(BOOL)left FluxStore:(VZFluxStore* )store{
    

    return [VZFButtonNode newWithButtonAttributes:{
        .title = @"Change Title Color",
        .titleColor = [UIColor whiteColor],
        .fontSize = 16,
        .action = [VZFBlockAction action:^(id sender) {
            //change state
            [store.dispatcher dispatch:{
                .source =VZ::ActionType::view_state,
                .payload = @{@"left":@(!left),@"index":props.indexPath}
            } mode:VZFStateUpdateModeAsynchronous];
        }]
        
    } NodeSpecs:{
        .userInteractionEnabled = 1,
        .backgroundColor = [UIColor orangeColor],
        .marginRight = 12,
        .flexGrow=1,
        .height = 24,
    }];
}
+ (VZFButtonNode* )RightButtonNodeWithProps:(PostItem* )props FluxStore:(VZFluxStore* )store{
    return [VZFButtonNode newWithButtonAttributes:{
        .title = @"Alert",
        .titleColor = [UIColor whiteColor],
        .fontSize = 16,
        .action = [VZFBlockAction action:^(id sender) {
            //change state
            [store.dispatcher dispatch:{
                .source =VZ::ActionType::view_action,
                .payload = @{@"index":props.indexPath}
            } mode:VZFStateUpdateModeAsynchronous];
        }]
    } NodeSpecs:{
        .userInteractionEnabled = 1,
        .backgroundColor = [UIColor orangeColor],
        .flexGrow=1,
        .height = 24
        
    }];
}
@end
