//
//  VZFluxAppDispatcher.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxAppDispatcher.h"

@implementation VZFluxAppDispatcher{

}

+ (instancetype)sharedInstance{
    
    static VZFluxAppDispatcher* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VZFluxAppDispatcher new];
    });
    return instance;
}

+ (VZFluxDispatcher* )dispatcher{

    return [VZFluxDispatcher new];
}

- (void)handleAction:(const FluxAction&) action
{
    [self dispatch:action mode:VZFStateUpdateModeSynchronous];
}


@end
