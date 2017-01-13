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
            case left:{
                
                [self emitChange:LEFT_BTN_CLICKED];
                break;
            }
            case right:{
                
                [self emitChange:RIGHT_BTN_CLICKED];
                break;
            }
            default:
                break;
        }
    }

}

@end
