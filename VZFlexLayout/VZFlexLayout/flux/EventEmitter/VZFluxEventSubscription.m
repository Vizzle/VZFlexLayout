//
//  VZFluxEventSubscription.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxEventSubscription.h"
#import "VZFluxEventSubscriber.h"


@implementation VZFluxEventSubscription


- (id)initWithSubscriber:(VZFluxEventSubscriber *)subscriber{

    self = [super init];
    if (self) {
        _subscriber = subscriber;
    }
    return self;
}
- (void)remove{

    [_subscriber removeSubscription:self];
    _subscriber = nil;
}


@end


@implementation VZFluxEmitterSubscription

- (id)initWithSubscriber:(VZFluxEventSubscriber *)subscriber Listener:(VZFluxEventListener)listener Context:(id)context{
    self = [super initWithSubscriber:subscriber];
    if (self) {
        _listener = [listener copy];
        _context  = context;
        
    }
    return self;

}

@end

