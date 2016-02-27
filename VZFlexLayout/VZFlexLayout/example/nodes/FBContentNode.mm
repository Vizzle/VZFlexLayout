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
#import "FBHostItem.h"

@implementation FBContentNode


+ (id)initialState{


    return @(NO);

}

+ (instancetype)newWithItem:(FBHostItem *)item
{
    VZ::Scope scope(self);
    NSNumber* state = scope.state();

    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{
    
        .flex = {
            .margin = 10,
        }
    
    
    } TextAttributes:{
        
        .text = item.content,
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
        .actionSelector = {
            {UIControlEventTouchUpInside, @selector(didTap:)},
           // {UIControlEventTouchDown, @selector(touchDown)}
        },

    }];
    
    
//    VZFNetworkImageNode* networkImageNode = [VZFNetworkImageNode newWithURL:[NSURL URLWithString:@"http://www.collegedj.net/wp-content/uploads/2016/02/CaOn9TMUcAATRy_-150x150.jpg"] ImageAttributes:{
//        .contentMode = UIViewContentModeScaleAspectFill
//    } NodeSpecs:{
//        .view = {
//            .backgroundColor = [UIColor grayColor],
//            .clipToBounds = YES,
//            .layer = {
//                .cornerRadius = 10,
//            }
//        },
//        .flex = {
//            .width = 200,
//            .height = 200,
//            .marginTop = 10,
//            .marginLeft = 10
//        }
//        
//    
//    } ImageDownloader:[FBImageDownloader sharedInstance] ImageProcessingBlock:nil];
    
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .flex = {
            .stackLayout = { .direction = VZFlexVertical }
        }
    
    } Children:{
    
        {.node = textNode},
        {.node = buttonNode},
//        {.node = networkImageNode}
    
    }];
    

    
    FBContentNode* headNode =  [super newWithNode:stackNode];
    
    return headNode;
}

- (void)didTap:(id)sender {
    NSLog(@"%@ didTap", NSStringFromClass([sender class]));
    [self updateState:^id(NSNumber* oldState) {
        
        id state =  @(![oldState boolValue]);
        return state;
        
    }];
}

@end
