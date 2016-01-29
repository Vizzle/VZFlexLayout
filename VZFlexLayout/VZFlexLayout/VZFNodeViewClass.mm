//
//  VZFNodeViewClass.cpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#include "VZFNodeViewClass.h"


#pragma-mark Constructor

VZ::ViewClass::ViewClass():factory(nil){}
VZ::ViewClass::ViewClass(Class clz):factory(^{return [[clz alloc] init];}){}

