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

@implementation FBContentNode


+ (id)initialState{


    return @(NO);

}

+ (instancetype)newWithItem:(FBHostItem *)item
{
    VZ::Scope scope(self);
    NSNumber* state = scope.state();

    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{} TextAttributes:{
        
        .text = item.content,
        .font = [UIFont systemFontOfSize:14.0f],
        .maximumNumberOfLines = [state boolValue] ? 0UL : 4UL
    
    }];
    
    VZFButtonNode* buttonNode = [VZFButtonNode newWithNodeSpecs:{
    
        .flex = {.alignSelf = VZFlexStart,.marginTop = 5}
    
    } ButtonAttributes:{
        
        .title = [state boolValue] ? @"收起":@"展开",
        .titleColor = [UIColor redColor],
        .font = [UIFont systemFontOfSize:14.0f],
        .actionSelector = {
            {UIControlEventTouchUpInside, @selector(didTap:)},
           // {UIControlEventTouchDown, @selector(touchDown)}
        },

    }];
    
    FBGridImageNode* imageNode = [FBGridImageNode newWithImageURLs:item.images];

    
    VZFStackNode* location = [VZFStackNode newWithStackSpecs:{
    
        .view = {
            .backgroundColor = [UIColor lightGrayColor]
        },
        .flex= {
            .marginTop = 10,
            .stackLayout = {.spacing = 10}
        }
    } Children:{
    
        {[VZFImageNode newWithNodeSpecs:{
            .flex = {
                .marginLeft = 5,
                .marginTop = 10,
                .marginBottom = 10,
            }
        } ImageAttributes:{.image = [UIImage imageNamed:@"comment_location"]}]},
        {[VZFTextNode newWithNodeSpecs:{} TextAttributes:{.text = item.location, .font = [UIFont systemFontOfSize:14.0f], .color = [UIColor blackColor]}]}
    
    }];
    
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        
        .flex = {
            .marginLeft = 40,
            .stackLayout = { .direction = VZFlexVertical }
        }
    
    } Children:{
    
        {.node = textNode},
        {.node = buttonNode},
        {.node = imageNode},
        {.node = location}
    
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
