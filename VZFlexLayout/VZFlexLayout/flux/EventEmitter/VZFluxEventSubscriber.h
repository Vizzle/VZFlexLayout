//
//  VZFluxEventSubscriber.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFluxEventSubscription;
@interface VZFluxEventSubscriber : NSObject

- (VZFluxEventSubscription* )addSubscription:(VZFluxEventSubscription* )sub EventType:(NSString* )eventType;
- (void)removeSubscription:(VZFluxEventSubscription* )subscription;
- (void)removeAllSubscriptions:(NSString* )eventType;
- (NSArray* )subscriptionsForEventType:(NSString* )eventType;

@end
