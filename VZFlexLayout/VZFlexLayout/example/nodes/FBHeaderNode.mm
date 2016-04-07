//
//  FBHeaderNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBHeaderNode.h"
#import "FBNameNode.h"
#import "FBStarNode.h"
#import "VZFStackNode.h"
#import "FBHostItem.h"
#import "VZFNetworkImageNode.h"
#import "FBImageDownloader.h"
#import "FBIconNode.h"

@implementation FBHeaderNode

+ (instancetype)newWithItem:(FBHostItem* )item{
    
    return [super newWithNode:[VZFStackNode newWithStackSpecs:{}Children:{
    
        {[FBIconNode newWithURL:[NSURL URLWithString:item.headIconURL]]},//头像
        {[VZFStackNode newWithStackSpecs:{
            
            .flex = {
                .marginLeft = 10,
                .flexGrow = 1,
                .stackLayout = {
//                    .spacing = 10,
                    .direction = VZFlexVertical,
                    .justifyContent = VZFlexSpaceBetween
                }
            }
        
        } Children:{
        
            {[FBNameNode newWithName:item.nick createTime:item.time]},//姓名+时间
            {[FBStarNode newWithScore:[item.score floatValue]]}, //星星
        }]},
    }]];

}

@end
