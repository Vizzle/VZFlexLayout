//
//  FBHostNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHostNode.h"
#import "FBHeaderNode.h"
#import "FBContentNode.h"
#import "FBHostItem.h"
#import <VZFlexLayout/VZFStackNode.h>
#import <VZFlexLayout/VZFNodeSpecs.h>


@implementation FBHostNode

+ (instancetype)newWithProps:(id)props Store:(id)store Context:(id)context{

    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical
    } NodeSpecs:{
        .padding = 10
    } Children:{
    
        {[FBHeaderNode  newWithProps:props Store:store Context:context]},
     //   {[FBContentNode newWithProps:props Store:store Context:context]},
    }];

//    FBContentNode* contentNode = [FBContentNode newWithProps:props Store:store Context:context];
    return [super newWithNode:stackNode];
}



@end
