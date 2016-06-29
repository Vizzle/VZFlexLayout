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
    
}


- (id)initWithDispatcher:(VZFluxDispatcher *)dispatcher{
    
    self = [super init];
    if (self) {
        
        _changed = false;
        _changeEvent = @"change";
        _dispatcher = dispatcher;
        _emitter = [[VZFluxEventEmitter alloc]init];
        
        __weak typeof(self) weakSelf = self;
        _dispatchToken = [dispatcher registerWithCallback:^(VZ::FluxAction payload) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf invokeOnDispatch:payload];
            }
        }];
        
    }
    return self;
}

- (void)addListener:(VZFluxStoreListener)listener{
    
    VZFluxEventSubscription* subscription = [_emitter addListener:^{
        
    } withEvent:_changeEvent Context:nil];

}

- (void)removeListener{
    
    [_emitter removeAllListenersForEvent:_changeEvent];

}



- (void)emitChange{

    _invariant(_dispatcher.isDispatching, @"%@.emitChange(): Must be invoked while dispatching.",[self class]);
    _changed = true;
}


- (void)invokeOnDispatch:(const FluxAction& )payload{

    _changed = NO;
    [self onDispatch:payload];
    if (_changed) {
        [_emitter emitEvent:self.changeEvent withData:nil];
    }
    
}

- (void)onDispatch:(const FluxAction&)payload{

    _invariant(false, @"%@ has not overridden FluxStore.__onDispatch(), which is required",[self class]);
}


@end


