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
+ (dispatch_queue_t)_stateUpdateQueue
{
    static dispatch_queue_t serialQueue = NULL;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        serialQueue = dispatch_queue_create("com.fluxstore.state-update", DISPATCH_QUEUE_SERIAL);
        
    });
    return serialQueue;
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

- (id)reduce:(id)state action:(const FluxAction& )action{
    return _state;
}

- (void)onDispatch:(const FluxAction&)action{
//    if(action.actionType == ActionType::state){
//        if(action.mode == async){
//            dispatch_async(_stateUpdateQueue, ^{
//                id newState = [self reduce:self->_state action: action];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self setState:newState];
//                });
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                id newState = [self reduce:self->_state action: action];
//                [self setState:newState];
//            });
//        }
//    
//        
//        
//    }else{
//        [_dispatcher dispatch:action mode:(VZFStateUpdateMode)action.mode];
//    }
}


@end


