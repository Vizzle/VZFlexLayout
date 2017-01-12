//
//  FBClickNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBClickNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFStackNode.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"
#import "VZFButtonNodeSpecs.h"
#import "VZFluxAction.h"
#import "FBActionType.h"
#import "VZFluxStore.h"

@implementation FBClickNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx{
    
    NSDictionary* data = (NSDictionary* )props;
    
    VZFButtonNode* btnNode=[VZFButtonNode newWithButtonAttributes:{
        .image = data[@"image"],
        .action = [VZFBlockAction action:^(id sender) {
            FluxAction::send ({
                
                .source = view_state,
                .actionType = [data[@"type"] isEqualToString:@"like"] ? LIKE_CLICKED_STATE:REWARD_CLICKED_STATE,
                .payload = @{@"index":ctx?:[NSNull null]},
                .dispatcher = store.dispatcher
                
            });
        }]
        
    }NodeSpecs:{
        .width = 20,
        .height = 20,
        
    } ];
    VZFTextNode* textNode = [VZFTextNode newWithTextAttributes:{
        .text = data[@"text"],
        .fontSize = 12.0f,
        .color = [UIColor lightGrayColor]
        
    }NodeSpecs:{} ];
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .spacing = 5,
    } NodeSpecs:{} Children:{
        {btnNode},
        {textNode}
    }];
    
    return [super newWithNode:stackNode];
    

}


@end
