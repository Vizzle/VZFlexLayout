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
            NSLog(@"%@",action.payload);
            [self emitChange];
            break;
        }
            
        default:
            break;
    }
    
}


@end
