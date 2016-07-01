//
//  VZFluxStoreAbstractMethods.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFluxAction.h"

@protocol VZFluxStoreAbstractMethods <NSObject>

- (id)initialState;
- (id)reduceState:(id)state WithAction:(const VZ::FluxAction&)action;

@end
