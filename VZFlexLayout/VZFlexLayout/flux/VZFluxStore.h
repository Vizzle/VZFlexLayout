//
//  VZFluxStore.h
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFluxAction.h"


using namespace VZ;
@class VZFluxDispatcher;
@class VZFluxEventEmitter;
@class VZFTuple;

typedef void(^VZFluxStoreListener)(NSString* eventType);

/**
 * Port from FluxStore.js
 *
 */
@interface VZFluxStore : NSObject

@property(nonatomic,assign,readonly) BOOL changed;
@property(nonatomic,strong,readonly) VZFluxDispatcher* dispatcher;
@property(nonatomic,strong,readonly)NSString* dispatchToken;
@property(nonatomic,strong,readonly)VZFluxEventEmitter* emitter;
@property(nonatomic,strong)NSString* changeEvent;

- (id)initWithDispatcher:(VZFluxDispatcher* )dispatcher;
- (void)addListener:(VZFluxStoreListener)listener;
- (void)removeListener;
- (void)emitChange;



@end

@interface VZFluxStore(Subclasses)

- (void)invokeOnDispatch:(const FluxAction&)action;
- (void)onDispatch:(const FluxAction&)action;

@end

