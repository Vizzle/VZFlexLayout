//
//  PostNode.m
//  VZFlexlayout-Demo
//
//  Created by Tao Xu on 9/17/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostNode.h"
#import "PostItem.h"
#import "PostItemStore.h"
#import <string>

using namespace VZ;
@implementation PostNode

+ (id)newWithProps:(PostItem* )props Store:(PostItemStore *)store Context:(id)ctx{
    
    VZFStackNode* container = [VZFStackNode newWithStackAttributes:{.direction = VZFlexVertical, .justifyContent = VZFlexStart}
                                                         NodeSpecs:{.margin = 12,}
                                                          Children:{
                                                              {[[self class] titleNodeWithProprs:props Store:store]},
                                                              {[[self class] bodyNodeWithProprs:props Store:store]},
                                                              {[[self class] buttonContainerWithProps:props Store:store]}
                                                          }];
    return [PostNode newWithNode:container];
}

+ (VZFTextNode* )titleNodeWithProprs:(PostItem* )props Store:(PostItemStore* )store {
 
    return [VZFTextNode newWithTextAttributes:{
        .text = props.title,
        .color = store.state[@"TITLE_COLOR"],
        .fontSize = 16,
        .fontStyle= VZFFontStyleBold,
        .lineBreakMode = VZFTextLineBreakByWord,
        .lines = 0
    } NodeSpecs:{}];
}

+ (VZFTextNode* )bodyNodeWithProprs:(PostItem* )props Store:(PostItemStore* )store{
    return [VZFTextNode newWithTextAttributes:{
        .text = props.body,
        .color = store.state[@"BODY_COLOR"],
        .fontSize = 12,
        .fontStyle= VZFFontStyleNormal,
        .lines = 0
    } NodeSpecs:{.marginTop = 10,}];
}

/*
 <stack>
    <button />
    <button/>
</stack>
 */
+ (VZFStackNode* )buttonContainerWithProps:(PostItem* )props Store:(VZFluxStore*) store{
    
    return  [VZFStackNode newWithStackAttributes:{.justifyContent=VZFlexStart}
                                       NodeSpecs:{.marginTop = 10}
                                        Children:{
                                            {[[self class] LeftButtonNodeWithProps:props Store:store]},
                                            {[[self class] RightButtonNodeWithProps:props Store:store]}
                                            
                                        }];
}

+ (VZFButtonNode* )LeftButtonNodeWithProps:(PostItem* )props Store:(VZFluxStore* )store{
    
    
    return [VZFButtonNode newWithButtonAttributes:{
        .title = @"Change Title Color",
        .titleColor = [UIColor whiteColor],
        .fontSize = 12,
        .action = [VZFBlockAction action:^(id sender) {
            //change state
            [store onDispatch:{
                .actionType = ActionType::state,
                .eventId = CHANGE_TITLE_COLOR,
                .payload = @{@"index" : props.indexPath}
            }];
        }]
        
    } NodeSpecs:{
        .userInteractionEnabled = 1,
        .backgroundColor = [UIColor orangeColor],
        .marginRight = 12,
        .flexGrow=1,
        .height = 24,
    }];
}
+ (VZFButtonNode* )RightButtonNodeWithProps:(PostItem* )props Store:(VZFluxStore* )store{
    return [VZFButtonNode newWithButtonAttributes:{
        .title = @"Change Next Item's Text Color",
        .titleColor = [UIColor whiteColor],
        .fontSize = 12,
        .action = [VZFBlockAction action:^(id sender) {
            //action
            [store onDispatch:{
                .actionType = ActionType::action,
                .eventId = CHANGE_BODY_COLOR,
                .payload = @{@"index":@(props.indexPath.row+1)}
            }];
            
        }]
    } NodeSpecs:{
        .userInteractionEnabled = 1,
        .backgroundColor = [UIColor orangeColor],
        .flexGrow=1,
        .height = 24
        
    }];
}
@end
