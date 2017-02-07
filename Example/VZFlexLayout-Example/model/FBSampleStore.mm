//
//  FBSampleStore.m
//  VZFlexLayout
//
//  Created by moxin on 16/7/12.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBSampleStore.h"
#import "FBActionType.h"
#import "FBSampleActionType.h"

@implementation FBSampleStore

- (void)onDispatch:(const VZ::FluxAction &)action{
    
    if (action.source == view_action) {
        switch (action.actionType) {
            case LEFT_BTN_CLICKED:{
                
                [self emitChange:BTN_CLICK_EVENT];
                break;
            }
            case RIGHT_BTN_CLICKED:{
                
                [self emitChange:BTN_CLICK_EVENT];
                break;
            }
            default:
                break;
        }
    }

}

@end
