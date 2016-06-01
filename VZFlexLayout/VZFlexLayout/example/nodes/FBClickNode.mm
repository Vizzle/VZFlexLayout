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

@implementation FBClickNode

+ (instancetype)newWithImage:(UIImage* )img Text:(NSString* )text Action:(SEL)action{


    VZFButtonNode* btnNode=[VZFButtonNode newWithButtonAttributes:{
        .image = img,
        .action = action
    }NodeSpecs:{
        .flex = {
            .width = 20,
            .height = 20,
        }
        
    } ];
    VZFTextNode* textNode = [VZFTextNode newWithTextAttributes:{
        .text = text,
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
