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

typedef void(^VZFluxStoreListener)(NSString* eventType, id data);

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
@protected
    BOOL _changed;
    id _state;
}

@property(nonatomic,strong,readonly) id state;
@property(nonatomic,strong,readonly) VZFluxDispatcher* dispatcher;
@property(nonatomic,strong,readonly) NSString* dispatchToken;

- (id)initWithDispatcher:(VZFluxDispatcher* )dispatcher;
- (void)addListener:(VZFluxStoreListener)listener;
- (void)removeListener;
- (void)emitChange;
- (void)emitChange:(NSString* )evenType;



@end

@interface VZFluxStore(Subclasses)

/**
 * This method encapsulates all logic for invoking onDispatch. It should
 * be used for things like catching changes and emitting them after the
 * subclass has handled a payload.
 */
- (void)invokeOnDispatch:(const FluxAction&)action;

/**
 * The callback that will be registered with the dispatcher during
 * instantiation. Subclasses must override this method. This callback is the
 * only way the store receives new data.
 */
- (void)onDispatch:(const FluxAction&)action;

@end

