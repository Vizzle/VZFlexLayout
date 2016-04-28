//
//  FBTextNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBTextNode.h"
#import "VZFTextNode.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNodeSpecs.h"
#import "FBHostItem.h"
#import "VZFStackNode.h"
#import "FBLocationNode.h"

@implementation FBTextNode

+ (instancetype)newWithItem:(FBHostItem* )item{


    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        .flex = {
            .stackLayout = VZFlexVertical,
            .margin = 10
        }

    } Children:{
        
        {[VZFTextNode newWithNodeSpecs:{} TextAttributes:{
            
            .text = item.content,
            .font = [UIFont systemFontOfSize:14.0f],
            .maximumNumberOfLines = 0
            
        }]},
        
        {item.location?[FBLocationNode newWithLocation:item.location]:nil}
    
    }];
    
    return [super newWithNode:stackNode];

}


@end
