//
//  FBScrollChildNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBScrollChildNode.h"
#import "VZFStackNode.h"
#import "VZFNodeSpecs.h"
#import "VZFTextNode.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "FBNetworkImageView.h"


@implementation FBScrollChildNode

+ (instancetype)newWithDictionary:(NSDictionary* )dictionary{

    VZFStackNode* stackNode = [VZFStackNode newWithStackSpecs:{
    
        .flex = {
            .stackLayout = {.direction = VZFlexVertical}
        }
    
    } Children:{
    
        {
            [VZFImageNode newWithImageAttributes:{
                .imageUrl = dictionary[@"image"]
            
            } NodeSpecs:{
                .flex= {
                    .width  =150,
                    .height = 150
                }
            
            } BackingImageViewClass:[FBNetworkImageView class]]
        },
        {
            [VZFTextNode newWithNodeSpecs:{
                .flex= {
                    .flexGrow = 1,
                    .alignSelf = VZFlexStretch
                }
            
            } TextAttributes:{
            
                .text = dictionary[@"name"],
                .fontSize = 14,
                .color = [UIColor redColor],
                .alignment = NSTextAlignmentCenter,
            }]
        }

    }];

    
    return [super newWithNode:stackNode];
}

@end
