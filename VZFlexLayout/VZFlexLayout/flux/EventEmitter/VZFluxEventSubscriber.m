//
//  VZFluxEventSubscriber.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxEventSubscriber.h"
#import "VZFluxEventSubscription.h"
#import "VZFMacros.h"

@implementation VZFluxEventSubscriber{
    
    NSMutableDictionary<NSString*, NSMutableArray* >* _subscriptionForType;
}

- (id)init{
    
    self = [super init];
    if (self) {
        _subscriptionForType = [NSMutableDictionary new];
        
    }
    return self;
}

- (VZFluxEventSubscription* )addSubscription:(VZFluxEventSubscription* )sub EventType:(NSString* )eventType {
    
    if (!_subscriptionForType[eventType]) {
        _subscriptionForType[eventType] = [NSMutableArray new];
    }
    
    NSMutableArray* list  = _subscriptionForType[eventType];
    [list addObject:sub];
    
    sub.eventType = eventType;
    sub.key = list.count;
    return sub;

}

- (void)removeSubscription:(VZFluxEventSubscription *)subscription{
    

}


- (void)removeAllSubscriptions:(NSString *)eventType{

    if (eventType.length == 0) {
        [_subscriptionForType removeAllObjects];
    }
    else{
        [_subscriptionForType removeObjectForKey:eventType];
    }
}

- (NSArray* )subscriptionsForEventType:(NSString *)eventType{
    
    return [_subscriptionForType[eventType] copy];
    
}


@end
