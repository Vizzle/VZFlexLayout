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


    VZFButtonNode* btnNode=[VZFButtonNode newWithNodeSpecs:{
        .flex = {
            .width = 20,
            .height = 20,
        }
        
    } ButtonAttributes:{
        .image = img,
        .action = action
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
