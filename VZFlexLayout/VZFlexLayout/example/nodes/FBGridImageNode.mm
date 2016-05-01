//
//  FBGridImageNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBGridImageNode.h"
#import "VZFStackNode.h"
#import "FBNetworkImageView.h"
#import "VZFNodeSpecs.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import <vector>

@implementation FBGridImageNode

+ (instancetype)newWithImageURLs:(NSArray* )list{

    std::vector<VZFStackChildNode > imageNodes{};
    for(int i=0; i<list.count; i++)
    {
        
        VZFImageNode* node = [VZFImageNode newWithImageAttributes:{
        
            .contentMode = UIViewContentModeScaleAspectFill,
            .imageUrl    = list[i]
        
        } NodeSpecs:{
        
        
            .view = {
                .clip = YES,
                .applicator = ^(UIView *view){
                    
                    view.userInteractionEnabled = YES;
                },
                .layer = {
                    .cornerRadius = 2.0f,
                    .borderWidth = 0.5f,
                    .borderColor = [UIColor grayColor]
                    
                    
                }
            },
            .gesture = @selector(imageDidTap),
            .flex = {
                .width = 76,
                .height = 76
            }
        
        
        } BackingImageViewClass:[FBNetworkImageView class]];
        
        

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


- (void)imageDidTap
{
    NSLog(@"abc");
}

@end
