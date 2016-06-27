//
//  VZFluxDispatcher.h
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFluxAction.h"


using namespace VZ;
typedef void(^DispatchPayload) (id payload);

/**
 *  The dispatcher is a singleton, and operates as the central hub of data flow in a Flux application. 
 It is essentially a registry of callbacks, and can invoke these callbacks in order. 
 Each store registers a callback with the dispatcher.
 When new data comes into the dispatcher, it then uses these callbacks to propagate that data to all of the stores. 
 The process of invoking the callbacks is initiated through the dispatch() method, which takes a data payload object as its sole argument. 
 This payload is typically synonymous with an action.
 */
@interface VZFluxDispatcher : NSObject
/*
 * Dispatcher is used to broadcast payloads to registered callbacks. This is different from generic pub-sub systems in two ways:
 
 Callbacks are not subscribed to particular events. Every payload is dispatched to every registered callback.
 Callbacks can be deferred in whole or part until other callbacks have been executed.
 *
 */

+ (void)handleAction:(const FluxAction& )action;

@end
