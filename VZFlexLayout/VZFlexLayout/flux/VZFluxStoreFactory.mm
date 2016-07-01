//
//  VZFluxStoreFactory.m
//  VZFlexLayout
//
//  Created by moxin on 16/6/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFluxStoreFactory.h"
#import "VZFluxStore.h"
#import "VZFluxReduceStore.h"
#import "VZFluxAppDispatcher.h"

@implementation VZFluxStoreFactory
{
    NSMutableDictionary* _map;
    int32_t _lastId;
}

+ (instancetype)sharedInstance{

    static dispatch_once_t onceToken;
    static VZFluxStoreFactory* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[VZFluxStoreFactory alloc]init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _map = [NSMutableDictionary new];
        _lastId = 1;
        
    }
    return self;
}

+ (VZFluxReduceStore* )storeWithClass:(Class)clz{

    return [self storeWithClass:clz Dispatcher:[VZFluxAppDispatcher sharedInstance]];
    

}

+ (VZFluxReduceStore* )storeWithClass:(Class )clz Dispatcher:(VZFluxDispatcher *)dispatcher{

    VZFluxStoreFactory* instance = [VZFluxStoreFactory sharedInstance];
    if (instance) {
        
        NSString* identifier = NSStringFromClass(clz);
        if (identifier) {
            if(instance -> _map[identifier]){
                return instance -> _map[identifier];
            }else{
                
                VZFluxReduceStore* reduceStore = [[clz alloc]initWithDispatcher:dispatcher];
                instance -> _map[identifier] = reduceStore;
                return reduceStore;
                
            }
        }
        else{
            return nil;
        }
    }
    else{
        return nil;
    }
}

@end
