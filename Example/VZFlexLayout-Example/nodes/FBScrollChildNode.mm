//
//  FBScrollChildNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBScrollChildNode.h"
#import <VZFlexLayout/VZFlexLayout.h>
#import "FBNetworkImageView.h"
#import "FBActionType.h"




@implementation FBScrollChildNode

+ (instancetype)newWithProps:(FBScrollItem* )item Store:(VZFluxStore *)store Context:(NSNumber* )ctx{
//+ (instancetype)newWithScrollItem:(FBScrollItem *)item Index:(uint32_t)index{
    FBScrollItemState state = item.state;
    
    VZFNode* buttonNode = [VZFButtonNode newWithButtonAttributes:{
        .fontSize = 13,
        .titleColor = [UIColor whiteColor],
        .title = item.name,
//        .action = ^(id sender){
//            
//            FluxAction::send({
//                
//                .source = ActionType::view_action,
//                .actionType = BUTTON_CLICKED,
//                .payload = @{@"data":item, @"index":ctx},
//                .dispatcher = store.dispatcher
//                
//            });
//        }

    }NodeSpecs:{

            .clip = YES,
            .cornerRadius = 12,
            .backgroundColor = [UIColor redColor],


            .alignSelf = VZFlexCenter,
            .height = 24,
            .width = 100,
            .marginTop = 10,
            .marginBottom = 10

    } ];
    
    VZFNode* spinnerNode = [VZFNode newWithView:{
        ^{
            UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            loadingIndicator.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
            loadingIndicator.color = [UIColor redColor];
            return loadingIndicator;
        },@"spinnerNode"} NodeSpecs:{
            

                .width = 20,
                .height = 20,
                .marginTop = 10,
                .marginBottom = 10,


                .applicator = ^(UIView *view){
                    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)view;
                    [indicator startAnimating];
                }

            
        }];
    
    VZFNode* node = nil;
    switch (state) {
        case kDefault:
            node = buttonNode;
            break;
        case kLoaded:
            node =spinnerNode;
            break;
            
        default:
            node = buttonNode;
            break;
    }
    
    VZFStackNode* stackNode = [VZFStackNode newWithStackAttributes:{.direction = VZFlexVertical}
                                                         NodeSpecs:{}
                                                          Children:{
        {[VZFImageNode newWithImageAttributes:{.imageUrl = item.imagePath}
                                       NodeSpecs:{
                                           .borderWidth = 1,
                                           .borderColor = [UIColor redColor],
                                           .cornerRadius = 10,
                                           .clip = YES,
                                           .width  =150,
                                           .height = 150,
//                                           .gesture = ^(id sender){
//                                               
//                                               FluxAction::send({
//                                                   
//                                                   .source = ActionType::view_action,
//                                                   .actionType = IMG_CLICKED,
//                                                   .payload = @{@"data":item, @"index":ctx},
//                                                   .dispatcher = store.dispatcher
//                                                   
//                                               });
//                                           }
                                       
                                       }
                            BackingImageViewClass:[FBNetworkImageView class]]},
        { node }

    }];
    
    return [super newWithNode:stackNode];
}

@end
