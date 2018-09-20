//
//  VZFluxStore.m
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFluxStore.h"
#import "VZFluxDispatcher.h"
#import "VZFMacros.h"

using namespace VZ;
@implementation VZFluxStore
{
    __weak VZFluxDispatcher* _dispatcher;
    VZFluxStoreListener _listener;
}

+ (id)initialState{
    return nil;
}

- (id)initWithDispatcher:(VZFluxDispatcher *)dispatcher{
    
    self = [super init];
    if (self) {
    
        _dispatcher = dispatcher;
        _state = [[self class] initialState];
        
    }
    return self;
}
- (void)setState:(id)state{
    if(_state != state){
        _state = state;
        if(_listener){
            _listener(-1,TRUE);
        }
    }
}
- (void)addListener:(VZFluxStoreListener)listener{
    _listener  = [listener copy];
}

- (void)removeListener{
    _listener = nil;
    
}

- (id)reducer:(id)state action:(const FluxAction& )action{
    return _state;
}

- (void)onDispatch:(const FluxAction&)action{
    if(action.actionType == ActionType::state){
        id newState = [self reducer:_state action: action];
        [self setState:newState];
    }else{
        [_dispatcher dispatch:action mode:(VZFStateUpdateMode)action.mode];
    }
    
}


@end


