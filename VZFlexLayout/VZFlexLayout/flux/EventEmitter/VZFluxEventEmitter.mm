//
//  VZFluxEventEmitter.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxEventEmitter.h"
#import "VZDynamicBlock.h"

@implementation VZFluxEventEmitter
{
    VZFluxEmitterSubscription* _currentSubscription;
    VZFluxEventSubscriber* _subscriber;
}

- (id)init{
    self = [super init];
    if (self) {
        
        _currentSubscription = nil;
        _subscriber = [VZFluxEventSubscriber new];
        
    }
    return self;

}


- (VZFluxEmitterSubscription* )addListener:(VZFluxEventListener)listener withEvent:(NSString* )eventType Context:(id)context{

    VZFluxEmitterSubscription* subscription = [[VZFluxEmitterSubscription alloc]initWithSubscriber:_subscriber Listener:listener Context:context];
    return (VZFluxEmitterSubscription* )[_subscriber addSubscription:subscription EventType:eventType];

}

- (void)removeAllListenersForEvent:(NSString* )eventType{
    
    [_subscriber removeAllSubscriptions:eventType];

}

- (void)removeCurrentListener{

    if (_currentSubscription) {
        [_subscriber removeSubscription:_currentSubscription];
    }

}

- (NSArray* )listenersForEvent:(NSString* )eventType{

    NSArray* subcriptions = [_subscriber subscriptionsForEventType:eventType];
    
    NSMutableArray* list = [NSMutableArray new];
    
    for(VZFluxEmitterSubscription* subscripiton in subcriptions){
        if (subscripiton.listener) {
            [list addObject:subscripiton.listener];
        }
    }
    return [list copy];

}

- (void)emitEvent:(NSString* )eventType withData:(VZFTuple* )data{
    
    NSArray* listeners = [self listenersForEvent:eventType];
    for (VZFluxEventListener listener in listeners) {
        if (listener) {
            [VZDynamicBlock invokeBlock:listener withArguments:data];
        }
    }
    

}
@end
