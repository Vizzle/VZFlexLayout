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

typedef void(^VZFluxStoreListener)(int32_t eventId, BOOL stateChanged);
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

- (id)initialState;
- (id)reduce:(id)state action:(const FluxAction& )action;
- (void)onDispatch:(const FluxAction&)action;

@end

