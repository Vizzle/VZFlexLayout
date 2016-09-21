//
//  VZFNodeMacros.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

#ifndef VZ_NOT_DESIGNATED_INITIALIZER
#define VZ_NOT_DESIGNATED_INITIALIZER() \
do { \
NSAssert2(NO, @"%@ is not the designated initializer for instances of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class])); \
return nil; \
} while (0)
#endif 

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

#define _invariant(condition,description,...) NSAssert(condition, description, ##__VA_ARGS__)
