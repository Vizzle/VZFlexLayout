//
//  VZFluxDispatcher.h
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFluxAction.h"
#import "VZFStateUpdateMode.h"


/**
 *  Implementation based on Dispatcher.js
 */
using namespace VZ;
typedef void(^DispatchCallback) (FluxAction payload);

/**
 Dispatcher is used to broadcast payloads to registered callbacks. This is different from generic pub-sub systems in two ways:
 
 Callbacks are not subscribed to particular events. Every payload is dispatched to every registered callback.
 Callbacks can be deferred in whole or part until other callbacks have been executed.
 */
@interface VZFluxDispatcher : NSObject

@property(nonatomic,assign,readonly)BOOL isDispatching;

/**
 *  Registers a callback to be invoked with every dispatched payload. Returns a token that can be used with waitFor().
 *
 *  @param callback function
 *
 *  @return registered token
 */
- (NSString* )registerWithCallback:(DispatchCallback)callback;
/**
 *  Removes a callback based on its token.
 *
 *  @param token registered token
 */
- (void)unregister:(NSString* )token;
/**
 *  Waits for the callbacks specified to be invoked before continuing execution of the current callback. 
 *  This method should only be used by a callback in response to a dispatched payload.
 *
 *  @param list wait for callback list
 *  @param m    update mode
 */
- (void)waitFor:(NSArray<NSString* > *)list mode:(VZFStateUpdateMode)m;
/**
 *  Dispatches a payload to all registered callbacks.
 */
- (void)dispatch:(FluxAction)action mode:(VZFStateUpdateMode)m;


@end
