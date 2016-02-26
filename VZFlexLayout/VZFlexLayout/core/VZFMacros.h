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
#endif // CK_NOT_DESIGNATED_INITIALIZER


