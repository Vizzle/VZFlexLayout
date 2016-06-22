//
//  VZFluxDispatcher.m
//  O2OReact
//
//  Created by moxin on 16/6/2.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFluxDispatcher.h"

@implementation VZFluxDispatcher

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken = 0;
    static VZFluxDispatcher* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [VZFluxDispatcher new];
    });
    return instance;
}

+ (void)handleAction:(const VZ::FluxAction &)action{
    //todo..
}

@end
