//
//  FBContentNodeStore.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBContentNodeStore.h"
#import "FBActionType.h"
#import <UIKit/UIKit.h>


@implementation FBContentNodeStore{
    NSMutableArray* _states;
}

- (id)initialStateAtIndex:(NSInteger)index{

    return [_states objectAtIndex:index];
}

- (void)addNewState{
    if (!_states) {
        _states = [NSMutableArray new];
    }
    [_states addObject:@{@"expend":@(NO), @"like":@(NO), @"reward":@(NO)}];
    _state = [_states copy];

}

- (void)onDispatch:(const VZ::FluxAction &)action{

    if (action.source == view_state) {
        
        NSDictionary* payload = (NSDictionary* )action.payload;
        NSDictionary* oldState = [_states objectAtIndex:((NSIndexPath* )payload[@"index"]).row];
        NSDictionary* newState = oldState;
        
        switch (action.actionType) {
            case EXPEND_CLICKED_STATE:
            {
                BOOL expend = ![oldState[@"expend"] boolValue];
                
                newState =  @{@"expend":@(expend),@"like":oldState[@"like"],@"reward":oldState[@"reward"]};
                break;
            }
            case LIKE_CLICKED_STATE:
            {
                BOOL like = ![oldState[@"like"] boolValue];
                newState =  @{@"expend":oldState[@"expend"],@"like":@(like),@"reward":oldState[@"reward"]};
                break;
            }
            case REWARD_CLICKED_STATE:{
                BOOL reward = ![oldState[@"reward"] boolValue];
                newState =  @{@"expend":oldState[@"expend"],@"like":oldState[@"like"],@"reward":@(reward)};
                break;
            }
                
            default:{break;}
        }
        [_states replaceObjectAtIndex:((NSIndexPath* )payload[@"index"]).row  withObject:newState];
        _state = [_states copy];
        
        //fire change state;
        [self emitChange];
    }
    else{
        switch (action.actionType) {
            case LOAD_DETAIL:
            {
                //如果需要controller做操作就emmit change
                NSLog(@"%@",action.payload);
                [self emitChange];
                break;
            }
                
            default:
                break;
        }
    
    }

}






@end
