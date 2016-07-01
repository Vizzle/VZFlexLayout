//
//  VZFluxReduceStore.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxReduceStore.h"
#import "VZFMacros.h"
#import "VZFluxEventEmitter.h"
#import "VZFluxAction.h"


@implementation VZFluxReduceStore
{

}

- (id)initialState{
    return nil;
}

- (id)reduceState:(id)state WithAction:(const FluxAction& )action{
    return state;
}


- (id)initWithDispatcher:(VZFluxDispatcher *)dispatcher{
    
    self = [super initWithDispatcher:dispatcher];
    if (self) {
        
        _state = [self initialState];
        
    }
    return self;

}

- (void)invokeOnDispatch:(const VZ::FluxAction &)action{
    
    _changed = NO;
    
    if (action.source == view_state) {
        
        // Reduce the stream of incoming actions to state, update when necessary.
        id startingState = _state;
        id endState = [self reduceState:_state WithAction:action];
        
        _invariant([startingState class] == [endState class], @"state class inconsistancy!");
        
        if (startingState != endState) {
            
            _state = endState;
            [self emitChange];
        }
        
    }
    else{
    
        [self onDispatch:action];
    
    }

    if (_changed) {
        [self.emitter emit:self.changeEvent withData:action.payload];
    }

}

- (void)onDispatch:(const VZ::FluxAction &)action{

    //empty
}


- (BOOL)isEqual:(id)object{
    
    if (![object isKindOfClass:[VZFluxReduceStore class]]) {
        return NO;
    }
    else{
        VZFluxReduceStore* store = (VZFluxReduceStore* )object;
        return store.state == self.state;
    }
    
}

@end
