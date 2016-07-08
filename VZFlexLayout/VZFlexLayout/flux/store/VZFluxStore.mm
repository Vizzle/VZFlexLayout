//
//  VZFluxStore.m
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFluxStore.h"
#import "VZFluxDispatcher.h"
#import "VZFluxEventEmitter.h"
#import "VZFluxEventSubscription.h"
#import "VZFMacros.h"

@implementation VZFluxStore
{
    NSString* _dispatchToken;
    VZFluxStoreListener _listener;
}


- (id)initWithDispatcher:(VZFluxDispatcher *)dispatcher{
    
    self = [super init];
    if (self) {
        
        _changed = false;
        _changeEvent = @"change";
        _dispatcher = dispatcher;
        _emitter = [[VZFluxEventEmitter alloc]init];
        
        __weak typeof(self) weakSelf = self;
        _dispatchToken = [dispatcher registerWithCallback:^(const VZ::FluxAction& action) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf invokeOnDispatch:action];
            }
        }];
        
    }
    return self;
}

- (void)addListener:(VZFluxStoreListener)listener{
    _listener  = [listener copy];
}

- (void)removeListener{
    _listener = nil;
    
}

- (void)emitChange{

    _invariant(_dispatcher.isDispatching, @"%@.emitChange(): Must be invoked while dispatching.",[self class]);
    _changed = true;
}

- (void)invokeOnDispatch:(const FluxAction& )action{

    _changed = NO;
  
    
    //sub class override
    [self onDispatch:action];
    

    if (_changed) {
        
        if (_listener) {
            _listener(_changeEvent,action.payload);
        }
    }
    
}

- (void)onDispatch:(const FluxAction&)payload{

    _invariant(false, @"%@ has not overridden FluxStore.__onDispatch(), which is required",[self class]);
}


@end


