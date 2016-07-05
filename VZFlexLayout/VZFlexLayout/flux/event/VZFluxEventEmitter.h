//
//  VZFluxEventEmitter.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFluxEventSubscriber.h"
#import "VZFluxEventSubscription.h"
#import "VZFValue.h"
/**
 *   In order to build "Flux Store" I have to build EventEmitter first.
 *   Sad story 😢
 *   Implementation based on EventEmitter.js. see:https://github.com/facebook/emitter
 */
@interface VZFluxEventEmitter : NSObject

/**
 *  Adds a listener to be invoked when events of the specified type are
 *  emitted. An optional calling context may be provided. The data arguments
 *  emitted will be passed to the listener function.
 *
 *  @param listener  Function to invoke when the specified event is emitted
 *  @param eventType Name of the event to listen to
 *  @param context   Optional context object to use when invoking the listener
 */
- (VZFluxEmitterSubscription* )addListener:(VZFluxEventListener)listener withEvent:(NSString* )eventType Context:(id)context;

/**
 * Similar to addListener, except that the listener is removed after it is
 * invoked once.
 *
 * @param {string} eventType - Name of the event to listen to
 * @param {function} listener - Function to invoke only once when the
 *   specified event is emitted
 * @param {*} context - Optional context object to use when invoking the
 *   listener
 */
- (VZFluxEmitterSubscription* )once:(NSString* )eventType do:(VZFluxEventListener)listener Context:(id)context;
/**
 * Removes all of the registered listeners, including those registered as
 * listener maps.
 *
 *  @param eventType Optional name of the event whose registered listeners to remove
 */
- (void)removeAllListenersForEvent:(NSString* )eventType;

- (void)removeCurrentListener;

- (NSArray* )listenersForEvent:(NSString* )eventType;

- (void)emit:(NSString* )event withData:(id)data;


@end
