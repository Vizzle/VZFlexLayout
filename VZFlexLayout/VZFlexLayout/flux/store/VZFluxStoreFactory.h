//
//  VZFluxStoreFactory.h
//  VZFlexLayout
//
//  Created by moxin on 16/6/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VZFluxDispatcher;
//@class VZFluxStore;
@class VZFluxReduceStore;
@interface VZFluxStoreFactory : NSObject

+ (VZFluxReduceStore* )storeWithClass:(Class )clz;
+ (VZFluxReduceStore* )storeWithClass:(Class)clz Dispatcher:(VZFluxDispatcher* )dispatcher;


@end

