//
//  FBListStore.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBScrollNodeStore.h"
#import "FBActionType.h"


@implementation FBScrollNodeStore


- (void)onDispatch:(const VZ::FluxAction &)action{

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


@end
