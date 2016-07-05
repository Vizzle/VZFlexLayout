//
//  VZFluxReduceStore.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxStore.h"
#import "VZFluxStoreAbstractMethods.h"

/**
 * This is the basic building block of a Flux application. All of your stores
 * should extend this class.
 * 
 * Implemention base on FluxReduceStore.js
 * see:https://github.com/facebook/flux/blob/master/src/stores/FluxReduceStore.js
 * 
 * @example:
 *   class CounterStore extends VZFluxReduceStore {
 *     nitialState(): number {
 *       return 1;
 *     }
 *
 *     reduce(state: number, action: Object): number {
 *       switch(action.type) {
 *         case: 'add':
 *           return state + action.value;
 *         case: 'double':
 *           return state * 2;
 *         default:
 *           return state;
 *       }
 *     }
 *   }
 */
@interface VZFluxReduceStore : VZFluxStore <VZFluxStoreAbstractMethods>
{
@protected
    id _state;
}

/**
 * Getter that exposes the entire state of this store. If your state is not
 * immutable you should override this and not expose _state directly.
 */
@property(nonatomic,strong,readonly) id state;

@end
