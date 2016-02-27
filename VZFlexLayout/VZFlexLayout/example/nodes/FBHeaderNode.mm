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

@implementation FBHeaderNode

+ (instancetype)newWithItem:(FBHostItem* )item{

    
    VZFNetworkImageNode* iconNode = [VZFNetworkImageNode newWithURL:[NSURL URLWithString:item.headIconURL]
                                                    ImageAttributes:{.contentMode = UIViewContentModeScaleAspectFill}
                                                          NodeSpecs:{
                                                                            .view = {
                                                                                .clipToBounds = YES,
                                                                                .backgroundColor = [UIColor grayColor],
                                                                                .layer = {.cornerRadius = 30.0f}
                                                                            },
                                                                            .flex = {
                                                                                .width = 60,
                                                                                .height = 60
                                                                            }}
                                                    ImageDownloader:[FBImageDownloader sharedInstance]
                                               ImageProcessingBlock:nil];
    
    VZFStackNode* righStackNode = [VZFStackNode newWithStackSpecs:{
        .flex = {
            .marginLeft = 10,
            .flexGrow = 1,
            .stackLayout = {
                .direction = VZFlexVertical,
                .justifyContent = VZFlexSpaceBetween
            }}
    
    } Children:{
        {[FBNameNode newWithName:item.nick createTime:item.time]},
        {[FBStarNode newWithScore:[item.score floatValue]]}
    }];

    
    VZFStackNode* headerNode =[VZFStackNode newWithStackSpecs:{} Children:{
        {iconNode},
        {righStackNode}
    }];
    
    return [super newWithNode:headerNode];

}


@end
