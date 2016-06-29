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

@implementation VZFluxReduceStore
{
    BOOL _changed;
}

- (id)initialState{
    return nil;
}

- (id)reduceState:(id)state WithAction:(id)action{
    return nil;

}


- (id)initWithDispatcher:(VZFluxDispatcher *)dispatcher{
    
    self = [super initWithDispatcher:dispatcher];
    if (self) {
        
        _state = [self initialState];
        
    }
    return self;

}

- (void)invokeOnDispatch:(const VZ::FluxAction &)action{
    
    _changed = false;
    
     // Reduce the stream of incoming actions to state, update when necessary.
    id startingState = _state;
    id endState = [self reduceState:_state WithAction:action];
    
    _invariant([startingState class] == [endState class], @"state class inconsistancy!");
    
    if (startingState != endState) {
        
        _state = endState;
        [self emitChange];
    }
    
    if (_changed) {
        [self.emitter emitEvent:self.changeEvent withData:nil];
    }

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
