//
//  FBContentNodeStore.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNodeStore.h"
#import "FBActionType.h"
@implementation FBContentNodeStore

- (id)initialState{

    return @{@"expend":@(NO), @"like":@(NO), @"reward":@(NO)};
}

- (id)reduceState:(NSDictionary* )state WithAction:(const VZ::FluxAction &)action{
    
    NSDictionary* result = nil;
    
    switch (action.actionType){
        case EXPEND_CLICKED_STATE:
        {
            BOOL expend = ![state[@"expend"] boolValue];

            result =  @{@"expend":@(expend),@"like":state[@"like"],@"reward":state[@"reward"]};
            break;
        }
        case LIKE_CLICKED_STATE:
        {
            BOOL like = ![state[@"like"] boolValue];
            result =  @{@"expend":state[@"expend"],@"like":@(like),@"reward":state[@"reward"]};
            break;
        }
        case REWARD_CLICKED_STATE:{
            BOOL reward = ![state[@"reward"] boolValue];
            result =  @{@"expend":state[@"expend"],@"like":state[@"like"],@"reward":@(reward)};
            break;
        }
            
        default:{
            result = [state copy];
            break;
        }
    }
    return result;
}




@end
