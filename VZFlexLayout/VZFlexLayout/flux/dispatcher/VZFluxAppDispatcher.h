//
//  VZFluxAppDispatcher.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxDispatcher.h"
#import "VZFluxAction.h"

using namespace VZ;
@interface VZFluxAppDispatcher : VZFluxDispatcher

+ (instancetype)sharedInstance;

+ (VZFluxDispatcher* )dispatcher;

- (void)handleAction:(const FluxAction&) action;


@end
