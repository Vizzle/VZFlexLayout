//
//  FBClickToExpendNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/13.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBClickToExpendNode.h"
#import "VZFNodeSpecs.h"
#import "VZFNodeViewClass.h"
#import "VZFStackNode.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"
#import "VZFButtonNode.h"
#import "VZFButtonNodeSpecs.h"
#import "VZFScope.h"
#import "FBHostItem.h"
#import "VZFNodeInternal.h"

@implementation FBClickToExpendNode

+ (id)initialState{

    return @{@"expend":@(NO)};
}

+ (instancetype)newWithItem:(FBHostItem* )item{

    VZ::Scope scope(self);
    NSDictionary* state = scope.state();
    
    VZFTextNode* nameNode = [VZFTextNode newWithNodeSpecs:{} TextAttributes:{
    
        .text = item.nick,
        .font = [UIFont systemFontOfSize:14.0f],
        
    }];
    
    
    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{
        
        .flex=  {.marginTop = 20}
    
    } TextAttributes:{
        
        .text = item.content,
        .font = [UIFont systemFontOfSize:14.0f],
        .maximumNumberOfLines = [state[@"expend"] boolValue] ? 0UL : 4UL
        
    }];
    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithNodeSpecs:{
        
        .flex = {.alignSelf = VZFlexStart,.marginTop = 5}
        
    } ButtonAttributes:{
        
        .title = [state[@"expend"] boolValue] ? @"收起":@"展开",
        .titleColor = [UIColor redColor],
        .font = [UIFont systemFontOfSize:14.0f],
        //        .action = ^(id sender){
        
        //        }
        .action = @selector(onExpendClicked:),
    }];

    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .flex = {.stackLayout = { .direction = VZFlexVertical}}
    
    } Children:{
        {nameNode},
        {textNode},
        {buttonNode}
    }];
    
    return [super newWithNode:stackNode];
}

- (void)onExpendClicked:(id)sender {
    
    [self updateState:^id(NSDictionary* oldState) {
        
        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"expend"] = @(![oldState[@"expend"] boolValue]);
        return [mutableOldState copy];
    }];
}

@end
