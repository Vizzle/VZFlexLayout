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
#import "VZFButtonNode.h"
#import "VZFScope.h"
#import "VZFNodeSubClass.h"

@implementation FBScrollChildNode

+ (instancetype)newWithDictionary:(NSDictionary* )dictionary{

    
    VZ::Scope scope(self,dictionary[@"name"]);
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
            [VZFButtonNode newWithNodeSpecs:{
                .flex = {
                    .width = 100,
                    .marginTop = 20,
                    .marginBottom = 20
                }
            } ButtonAttributes:{
            
                .fontSize = 14,
                .title = dictionary[@"name"],
                .titleColor = [UIColor redColor],
                .action = @selector(clicked:)
            
            }],
//            [VZFTextNode newWithNodeSpecs:{
//                .flex= {
//                    .flexGrow = 1,
//                    .alignSelf = VZFlexStretch
//                }
//            
//            } TextAttributes:{
//            
//                .text = dictionary[@"name"],
//                .fontSize = 14,
//                .color = [UIColor redColor],
//                .alignment = NSTextAlignmentCenter,
//            }]
        }

    }];

    
    return [super newWithNode:stackNode];
}

- (void)clicked:(id)sender{
    
    [self updateState:^id(id oldState) {
        
        return oldState;
    }];
}

@end
