//
//  PostItemStore.m
//  VZFlexlayout-Demo
//
//  Created by moxin on 9/19/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostItemStore.h"

@implementation PostItemStore

- (id)init{
    self = [super init];
    if(self){
        _state = @{@"left":@(FALSE)};
    }
    return self;
}

- (void)onDispatch:(const VZ::FluxAction &)action{
    NSIndexPath* indexPath = action.payload[@"index"];
    if(self.item.indexPath.row == indexPath.row){
        //compare old state with new state
        if(action.source == VZ::ActionType::view_state){
            if([_state[@"left"] boolValue] != [action.payload[@"left"] boolValue]){
                _state[@"left"] = action.payload[@"left"];
                [self emitChange:@"left"];
            }
        }else{
            [self emitChange:@"right"];
        }
    }
}

- (void)dealloc{
    NSLog(@"dealloc");
}

@end
