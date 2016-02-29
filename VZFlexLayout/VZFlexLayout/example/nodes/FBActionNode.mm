//
//  FBActionNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBActionNode.h"
#import "VZFButtonNode.h"
#import "VZFTextNode.h"
#import "VZFNodeInternal.h"
#import "VZFStackNode.h"

@implementation FBActionNode


+ (instancetype)newWithImage:(UIImage* )img Text:(NSString* )text Action:(SEL)action{
    
    VZFButtonNode* btnNode=[VZFButtonNode newWithNodeSpecs:{
        .flex = {
            .width = 20,
            .height = 20,
        }
    
    } ButtonAttributes:{
        .image = img,
        .actionSelector = action
    }];
    VZFTextNode* textNode = [VZFTextNode newWithNodeSpecs:{} TextAttributes:{
        .text = text,
        .font = [UIFont systemFontOfSize:12.0f],
        .color = [UIColor lightGrayColor]
    
    }];

    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        .flex= {.stackLayout = {.spacing = 5}}
        
    } Children:{
        {btnNode},
        {textNode}
    }];
    
    return [super newWithNode:stackNode];


}


@end
