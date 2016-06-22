//
//  FBIconNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/1.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBIconNode.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFNodeSpecs.h"
#import "FBNetworkImageView.h"
#import "VZFStackNode.h"

#import "VZFTextNode.h"

@implementation FBIconNode

+ (instancetype)newWithURL:(NSString* )url{
    
    VZFImageNode* iconNode = [VZFImageNode newWithImageAttributes:{
    
        .contentMode = UIViewContentModeScaleAspectFill,
        .imageUrl = url,

    
    
    } NodeSpecs:{
        
        .view = {
            .clip = YES,
            .backgroundColor = [UIColor grayColor],
            .layer = {.cornerRadius = 20.0f}
        },
        .flex = {
            .width = 40,
            .height = 40
        }
    
    } BackingImageViewClass:[FBNetworkImageView class]];


    return [super newWithNode:iconNode];

}


@end
