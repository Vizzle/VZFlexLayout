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

/**
 * Constructs the initial state for this store. This is called once during
 * construction of the store.
 */
- (id)initialState;
/**
 * Used to reduce a stream of actions coming from the dispatcher into a
 * single state object.
 */
- (id)reduceState:(id)state WithAction:(const VZ::FluxAction&)action;

/**
 * Checks if two versions of state are the same. You do not need to override
 * this if your state is immutable.
 
 * 如果old state和 new state不同，返回YES，相同返回NO，默认为NO
 */
- (BOOL)compareOldState:(id)oldState withNewState:(id)state;


@end
