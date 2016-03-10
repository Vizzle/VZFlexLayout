//
//  VZFScopeFrame.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFScopeFrame;
namespace VZ {
    
    struct ScopeFramePair{
        VZFScopeFrame* newScopeFrame;
        VZFScopeFrame* oldScopeFrame;
    };
};
typedef VZ::ScopeFramePair VZScopeFramePair;

@class VZFScopeHandler;
@class VZFRootScope;
@interface VZFScopeFrame : NSObject

@property(nonatomic,strong,readonly) VZFScopeHandler* handler;

- (id)initWithScopeHandler:(VZFScopeHandler* )scopeHandler;
+ (VZScopeFramePair)scopeFramePair:(const VZScopeFramePair& )pair
                NewRoot:(VZFRootScope* )newRoot
              NodeClass:(Class )nodeClz
             Identifier:(id)identifier
    InitialStateCreator:(id (^)())initialStateCreator
           StateUpdates:(NSDictionary* )stateUpdatesFunc;

@end



