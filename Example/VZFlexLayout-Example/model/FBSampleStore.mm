//
//  FBSampleStore.m
//  VZFlexLayout
//
//  Created by moxin on 16/7/12.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBSampleStore.h"
#import "FBActionType.h"

@implementation FBSampleStore

- (void)onDispatch:(const VZ::FluxAction &)action{
    
    if (action.source == view_action) {
        switch (action.actionType) {
            case IMG_CLICKED:{
                
                [self emitChange:IMG_EVENT];
                break;
            }
            case BUTTON_CLICKED:{
                
                [self emitChange:BTN_EVENT];
                break;
            }
            default:
                break;
        }
    }

}

@end
