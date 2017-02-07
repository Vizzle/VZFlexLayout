//
//  FBIconNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/1.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBIconNode.h"
#import "FBNetworkImageView.h"
#import <VZFlexLayout/VZFlexLayout.h>


@implementation FBIconNode

+ (instancetype)newWithURL:(NSString* )url{
    
    VZFImageNode* iconNode = [VZFImageNode newWithImageAttributes:{
    
        .contentMode = UIViewContentModeScaleAspectFill,
        .imageUrl = url,

    } NodeSpecs:{
        
        
            .clip = YES,
            .backgroundColor = [UIColor grayColor],
            .cornerRadius = 20.0f,
            .flexShrink = 0,
            .width = 40,
            .height = 40
        
    
    } BackingImageViewClass:[FBNetworkImageView class]];


    return [super newWithNode:iconNode];

}


@end
