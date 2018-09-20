//
//  PostItemStore.m
//  VZFlexlayout-Demo
//
//  Created by moxin on 9/19/18.
//  Copyright © 2018 Vizlab. All rights reserved.
//

#import "PostItemStore.h"
using namespace VZ;
@implementation PostItemStore



- (id)inittialState{
    return @{@"TITLE_COLOR":[UIColor blackColor],@(EXPEND_TEXT):@(FALSE),@"BODY_COLOR":[UIColor darkGrayColor]};
}

- (id)reducer:(NSDictionary* )state action:(const VZ::FluxAction &)action{
    
    if(action.eventId == CHANGE_TITLE_COLOR){
        
        NSMutableDictionary* oldState = [state mutableCopy];
        oldState[@"TITLE_COLOR"] = [oldState[@"TITLE_COLOR"] isEqual:[UIColor blackColor]]?[UIColor orangeColor] : [UIColor blackColor];
        return [oldState copy];
        
    }else if(action.eventId == CHANGE_BODY_COLOR){
        NSMutableDictionary* oldState = [state mutableCopy];
        oldState[@"BODY_COLOR"] = [oldState[@"BODY_COLOR"] isEqual:[UIColor darkGrayColor]]?[UIColor orangeColor] : [UIColor darkGrayColor];
        return [oldState copy];
    }else{
        return state;
    }
}
- (void)dealloc{
    NSLog(@"dealloc");
}

@end
