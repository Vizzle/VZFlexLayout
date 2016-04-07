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
#import "VZFNetworkImageNode.h"
#import "VZFScope.h"
#import "FBImageDownloader.h"
#import "VZFImageNode.h"
#import "FBHostItem.h"
#import "FBGridImageNode.h"
#import "VZFLineNode.h"
#import "FBActionNodes.h"
#import "FBLocationNode.h"

@implementation FBContentNode


+ (id)initialState{

    return @{@"like":@(NO)};
}

+ (instancetype)newWithItem:(FBHostItem *)item
{
    VZ::Scope scope(self);
    NSDictionary* state = scope.state();

    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{} TextAttributes:{
        
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
    
    FBGridImageNode* imageNode = [FBGridImageNode newWithImageURLs:item.images];

    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .flex = {
            .marginLeft = 40,
            .stackLayout = { .direction = VZFlexVertical }
        }
    
    } Children:{
        
        {item.content?textNode:nil},
        {item.content?buttonNode:nil},
        {item.images.count?imageNode:nil},
        {item.location?[FBLocationNode newWithLocation:item.location]:nil},
        {[FBActionNodes newWithItem:item]}
    
    }];
    
    FBContentNode* headNode =  [super newWithNode:stackNode];

    return headNode;
}




- (void)onExpendClicked:(id)sender {

    [self updateState:^id(NSDictionary* oldState) {
        
        NSMutableDictionary* mutableOldState = [oldState mutableCopy];
        mutableOldState[@"expend"] = @(![oldState[@"expend"] boolValue]);
        return [mutableOldState copy];
    }];
}

@end
