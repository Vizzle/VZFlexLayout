//
//  FBGridImageNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBGridImageNode.h"
#import "VZFStackNode.h"
#import "VZFNetworkImageNode.h"
#import "FBImageDownloader.h"
#import <vector>

@implementation FBGridImageNode

+ (instancetype)newWithImageURLs:(NSArray* )list{

    std::vector<VZFStackChildNode > imageNodes{};
    for(int i=0; i<list.count; i++)
    {
        VZFNetworkImageNode* node = [VZFNetworkImageNode newWithURL:[NSURL URLWithString:list[i]] ImageAttributes:{.contentMode = UIViewContentModeScaleAspectFill} NodeSpecs:{
            .view = {
                .clipToBounds = YES,
                .block = ^(UIView *view){view.userInteractionEnabled = YES;},
            },
            .gesture = @selector(imageDidTap),
            .flex = {
                .width = 76,
                .height = 76
            }
        } ImageDownloader:[FBImageDownloader sharedInstance] ImageProcessingBlock:nil];
       
        imageNodes.push_back({.node = node});
    }
    

    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
        .flex = {
            .wrap = YES,
            .marginTop = 10,
            .stackLayout = {
                .spacing = 10,
                .lineSpacing = 10
            }
        },
        
    } Children:imageNodes];
    
    return [super newWithNode:stackNode];

}

@end
