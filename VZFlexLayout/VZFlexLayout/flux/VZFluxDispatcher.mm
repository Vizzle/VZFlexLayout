//
//  VZFluxDispatcher.m
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFluxDispatcher.h"


const NSString* gFluxPrefix = @"ID_";

@implementation VZFluxDispatcher
{
    //{key:dispatchToken, value:callback}
    NSMutableDictionary<NSNumber*, DispatchPayload>*  _callbacks;
    
    //dispatching
    BOOL _isDispatching;
    
}


- (id)init{

    self = [super init];
    if (self) {
        
        _callbacks = [NSMutableDictionary new];
        
    }
    return self;
}

+ (void)handleAction:(const VZ::FluxAction &)action{
    //todo..
}

@end
