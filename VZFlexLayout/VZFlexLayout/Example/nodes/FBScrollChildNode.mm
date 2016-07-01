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
#import "VZFlux.h"
#import "FBActionType.h"
#import "FBScrollNodeStore.h"


@implementation FBScrollChildNode

+ (id)initialState{
    return [VZFluxStoreFactory storeWithClass:[FBScrollNodeStore class]].initialState;
}

+ (instancetype)newWithDictionary:(NSDictionary* )dictionary Index:(uint32_t)index{


    bool initialState = [[self initialState] boolValue];
    
    
    VZFNode* buttonNode = [VZFButtonNode newWithButtonAttributes:{
        .fontSize = 13,
        .titleColor = [UIColor whiteColor],
        .title = dictionary[@"name"],
        .action = ^(id sender){
            
            FluxAction action = {
                .source = ActionType::view_action,
                .actionType = LOAD_DETAIL,
                .payload = @{@"data":dictionary, @"index":@(index)}
            };
            sendAction(action);}

    }NodeSpecs:{
        .view = {
            .clip = YES,
            .layer = {.cornerRadius = 12},
            .backgroundColor = [UIColor redColor],
        },
        .flex = {
            .alignSelf = VZFlexCenter,
            .height = 24,
            .width = 100,
            .marginTop = 10,
            .marginBottom = 10
        }
    } ];
    
    VZFNode* spinnerNode = [VZFNode newWithView:{
        ^{
            UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            loadingIndicator.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
            loadingIndicator.color = [UIColor redColor];
            return loadingIndicator;
        },@"spinnerNode"} NodeSpecs:{
        
            .flex = {
                .width = 20,
                .height = 20,
                .marginTop = 10,
                .marginBottom = 10
            },
            .view = {
                .applicator = ^(UIView *view){
                    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)view;
                    [indicator startAnimating];
                }
            }
        
        }];


    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{.direction = VZFlexVertical}
                                                         NodeSpecs:{}
                                                          Children:{
        {
            [VZFImageNode newWithImageAttributes:{.imageUrl = dictionary[@"image"]}
                                       NodeSpecs:{.flex= {.width  =150,.height = 150}}
                            BackingImageViewClass:[FBNetworkImageView class]]
        },
        { initialState ? spinnerNode : buttonNode }

    }];
    
    return [super newWithNode:stackNode];
}

@end
