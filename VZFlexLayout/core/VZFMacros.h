//
//  VZFNodeMacros.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once
#import <pthread/pthread.h>

#ifndef VZ_NOT_DESIGNATED_INITIALIZER
#define VZ_NOT_DESIGNATED_INITIALIZER() \
do { \
NSAssert2(NO, @"%@ is not the designated initializer for instances of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class])); \
return nil; \
} while (0)
#endif 

//force category methods to be compiled. By inserting an empty bogus class
#define VZF_FORCE_CATEGORY_COMPILE(name) @interface VZF_FORCE_CATEGORY_COMPILE##name : NSObject @end \
@implementation VZF_FORCE_CATEGORY_COMPILE##name @end


#define VZFAssert(condition, description, ...) NSAssert(condition, description, ##__VA_ARGS__)
#define VZFCAssert(condition, description, ...) NSCAssert(condition, description, ##__VA_ARGS__)

#define VZFAssertNil(condition, description, ...) VZFAssert(!(condition), (description), ##__VA_ARGS__)
#define VZFCAssertNil(condition, description, ...) VZFCAssert(!(condition), (description), ##__VA_ARGS__)

#define VZFAssertNotNil(condition, description, ...) VZFAssert((condition), (description), ##__VA_ARGS__)
#define VZFCAssertNotNil(condition, description, ...) VZFCAssert((condition), (description), ##__VA_ARGS__)


#define VZFAssertTrue(condition) VZFAssert((condition), nil, nil)
#define VZFCAssertTrue(condition) VZFCAssert((condition), nil, nil)

#define VZFAssertFalse(condition) VZFAssert(!(condition), nil, nil)
#define VZFCAssertFalse(condition) VZFCAssert(!(condition), nil, nil)


#define VZFAssertMainThread() VZFAssert([NSThread isMainThread],nil,@"This method must be called on main thread!")
#define VZFCAssertMainThread() VZFCAssert([NSThread isMainThread],nil,@"This method must be called on main thread!")

#define VZFAssertNotMainThread()  VZFAssert(![NSThread isMainThread],nil,@"This method must be called off main thread!")
#define VZFCAssertNotMainThread()  VZFCAssert(![NSThread isMainThread],nil,@"This method must be called off main thread!")

//#define VZF_MainCall(block) \
//do{\
//if (![NSThread isMainThread]) { \
//    dispatch_async(dispatch_get_main_queue(), block);\
//}else{\
//    if(block){block();}\
//}\
//}while(0)


#define VZF_NAMED_DISPATCH_BLOCK(_name,_block)\
^{\
    NSThread* currentThread = [NSThread currentThread]; \
    NSString* oldName = currentThread.name;\
    currentThread.name = _name; \
    if (_block) {\
        _block();\
    }\
    currentThread.name = oldName;\
}

#define VZFNSLog(fmt, ...) NSLog(@"💬<Flex> " fmt,##__VA_ARGS__)

#define VZF_LOG_DEALLOC() VZFNSLog(@"[%@]-->dealloc(%p) on Thread#<%d,%d>",self.class,self, pthread_mach_thread_np(pthread_self()),[NSThread isMainThread])
#define VZFC_LOG_DEALLOC(arg) VZFNSLog(@"[%@]-->dealloc on Thread#<%d,%d>",arg, pthread_mach_thread_np(pthread_self()),[NSThread isMainThread])

#define VZF_LOG_THREAD(arg) VZFNSLog(@"[%@]-->%@(%p) on Thread#<%d,%d>",self.class, arg,self, pthread_mach_thread_np(pthread_self()),[NSThread isMainThread])
#define VZFC_LOG_THREAD(arg1,arg2) VZFNSLog(@"[%@]-->%@ on Thread#<%d,%d>",arg1, arg2, pthread_mach_thread_np(pthread_self()),[NSThread isMainThread])

//for flux use
#define _invariant(condition,description,...) NSAssert(condition, description, ##__VA_ARGS__)
