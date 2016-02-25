//
//  FBHeadNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHeadNode.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFStackNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFScope.h"
#import "VZFNodeViewManager.h"

@implementation FBHeadNode


+ (id)initialState{


    return @(NO);

}

+ (instancetype)newWithProps:(NSString *)props
{
    VZ::Scope scope(self);
    NSNumber* state = scope.state();

    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{
    
        .flex = {
            .margin = 10,
        }
    
    
    } TextAttributes:{
        
        .text = props,
        .maximumNumberOfLines = [state boolValue] ? 0UL : 4UL
    
    }];
    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithNodeSpecs:{
    
        .flex = {
        
            .alignSelf = VZFlexStart,
            .marginLeft = 10
        }
    
    } ButtonAttributes:{
        
        .title = [state boolValue] ? @"收起":@"展开",
        .titleColor = [UIColor redColor],
        .font = [UIFont systemFontOfSize:12.0f],
        .action = ^(UIButton* sender){
        
            [sender.node.parentNode updateState:^id(NSNumber* oldState) {
                
                return @(![oldState boolValue]);
                

            }];
        
        }

    }];
    
    
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .flex = {
            .stackLayout = { .direction = VZFlexVertical }
        }
    
    } Children:{
    
        {.node = textNode},
        {.node = buttonNode}
    
    }];
    

    
    FBHeadNode* headNode =  [super newWithNode:stackNode];
    
    return headNode;
}


@end
