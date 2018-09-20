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

typedef void(^VZFluxStoreListener)(int32_t eventId, BOOL stateChanged);



/**
 *
 * This class represents the most basic functionality for a FluxStore. Do not
 * extend this store directly; instead extend FluxReduceStore when creating a
 * new store.
 *
 * Implementation based on  FluxStore.js
 * See:"https://github.com/facebook/flux/blob/master/src/stores/FluxStore.js"
 *
 */

@interface VZFluxStore : NSObject{
}

@property(nonatomic,strong,readonly) id state;
@property(nonatomic,strong,readonly) NSString* dispatchToken;

- (id)initWithDispatcher:(VZFluxDispatcher* )dispatcher;
- (void)addListener:(VZFluxStoreListener)listener;
- (void)setState:(id)state;
- (void)removeListener;



@end

@interface VZFluxStore(Subclasses)

- (id)inittialState;
/*
 * (old_state, action) => new_state
 */
- (id)reducer:(id)state action:(const FluxAction& )action;
/**
 * The callback that will be registered with the dispatcher during
 * instantiation. Subclasses must override this method. This callback is the
 * only way the store receives new data.
 */
- (void)onDispatch:(const FluxAction&)action;

@end

