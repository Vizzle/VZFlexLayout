//
//  FBHeadNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNode.h"
#import "FBImageDownloader.h"
#import "FBHostItem.h"
#import "FBGridImageNode.h"
#import "FBActionNodes.h"
#import "FBLocationNode.h"
#import "FBContentNodeStore.h"
#import "FBActionType.h"
#import <VZFlexLayout/VZFlexLayout.h>


@implementation FBContentNode

+ (instancetype)newWithProps:(FBHostItem* )item Store:(FBContentNodeStore* )store Context:(NSIndexPath* )index{
    
    NSDictionary* state = [store initialStateAtIndex:index.row];

    VZFTextNode* textNode = [VZFTextNode newWithTextAttributes:{
        
        .text       = item.content,
        .fontSize   = 14.0f,
        .alignment  = NSTextAlignmentCenter,
        .fontName   = @"Helvetica Neue",
        .lines      = [state[@"expend"] boolValue] ? 0UL : 4UL,
        .color      = [UIColor blackColor],
        .lineSpacing = 4
        
    }NodeSpecs:{} ];
    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithButtonAttributes:{
        
        .title      = [state[@"expend"] boolValue] ? @"收起":@"展开",
        .titleColor = [UIColor redColor],
        .fontSize   = 14.0f,
//        .action     = ^(id sender){
//            
//            FluxAction::send({
//                .source = ActionType::view_state,
//                .actionType = EXPEND_CLICKED_STATE,
//                .payload = @{@"index":index?:[NSNull null]},
//                .dispatcher = store.dispatcher
//                
//            });
//        }
    }NodeSpecs:{
    
        .alignSelf = VZFlexStart,
        .marginTop = 5
    
    } ];
    
    FBGridImageNode* imageNode = [FBGridImageNode newWithImageURLs:item.images];

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical,
    } NodeSpecs:{
        .marginLeft = 40
    } Children:{
        
        {item.content?textNode:nil},
        {item.content?buttonNode:nil},
        {item.images.count?imageNode:nil},
        {item.location?[FBLocationNode newWithLocation:item.location]:nil},
        {[FBActionNodes newWithProps:item Store:store Context:index]}
    }];
    
    
    FBContentNode* contentNode =  [super newWithNode:stackNode];
    return contentNode;
}



@end
