//
//  FBHeadNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNode.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFStackNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFScope.h"
#import "FBImageDownloader.h"
#import "VZFImageNode.h"
#import "FBHostItem.h"
#import "FBGridImageNode.h"
#import "VZFLineNode.h"
#import "FBActionNodes.h"
#import "FBLocationNode.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"
#import "VZFButtonNodeSpecs.h"

@implementation FBContentNode


+ (id)initialState{

    return @{@"expend":@(NO)};
}

+ (instancetype)newWithItem:(FBHostItem *)item
{
    VZ::Scope scope(self);
    NSDictionary* state = scope.state();

    VZFTextNode* textNode = [VZFTextNode newWithTextAttributes:{
        
        .text       = item.content,
        .fontSize   = 14.0f,
        .lines      = [state[@"expend"] boolValue] ? 0UL : 4UL
        
    }NodeSpecs:{} ];
    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithButtonAttributes:{
        
        .title      = [state[@"expend"] boolValue] ? @"收起":@"展开",
        .titleColor = [UIColor redColor],
        .fontSize   = 14.0f,
        .action     = @selector(onExpendClicked:),
    }NodeSpecs:{
    
        .flex = {.alignSelf = VZFlexStart,.marginTop = 5}
    
    } ];
    
    FBGridImageNode* imageNode = [FBGridImageNode newWithImageURLs:item.images];

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical,
    } NodeSpecs:{
        .flex = {.marginLeft = 40}
    } Children:{
        
        {item.content?textNode:nil},
        {item.content?buttonNode:nil},
        {item.images.count?imageNode:nil},
        {item.location?[FBLocationNode newWithLocation:item.location]:nil},
        {[FBActionNodes newWithItem:item]}
        
    }];
    

    
    FBContentNode* contentNode =  [super newWithNode:stackNode];

    return contentNode;
}




- (void)onExpendClicked:(id)sender {

    [self updateState:^id(NSDictionary* oldState) {
        
        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"expend"] = @(![oldState[@"expend"] boolValue]);
        return [mutableOldState copy];
    } Mode:VZFStateUpdateModeSynchronous];
}

@end
