//
//  VZFStateScope.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <unordered_map>
#include <stack>
#import "VZFState.h"



//{key:scopeId, value:state_update_func}
typedef std::unordered_multimap<int32_t, id (^)(id)> VZFNodeStateUpdateMap;

namespace VZ {

    /**
     *  Node内部的State是封闭的，StateScope用来让Node在类方法内获取state
     */
    struct VZFScope{
        
        VZFScope(Class componentClz, id scopeId, id (^initialStateCreator)(void) = nil);
        ~VZFScope();
        
        id state() const;
        id scopeId() const;
        
    private:
        VZFScope(const VZFScope& ) = delete;
        VZFScope& operator=(const VZFScope& ) = delete;
        id _state;
        NSNumber* _scopeId;
    };
}




@interface VZFRootScope : NSObject

@property(nonatomic,weak,readonly) id<VZFStateListener> listener;
@property(nonatomic,assign,readonly) int32_t rootScopeId;
/**
 * 每个root scope绑定一个listener
 *
 *  @param listener node的state变化触发这个listener
 *
 *  @return scope
 */
+ (instancetype)rootScopeWithListener:(id<VZFStateListener>)listener;
- (instancetype)newRootScope;


@end

namespace VZ {
    
//    struct VZFScopePair {
//        CKComponentScopeFrame *frame;
//        CKComponentScopeFrame *equivalentPreviousFrame;
//    };
//    
//    struct LocalScopeBuilder{
//        
//        LocalScopeBuilder(VZFRootScope* previousRootScope, const VZFNodeStateUpdateMap& updates){
//        
//            
//        }
//        
//        VZFRootScope* const newRootScope;
//        const VZFNodeStateUpdateMap stateUpdates
//        std::stack
//    
//    };
}




