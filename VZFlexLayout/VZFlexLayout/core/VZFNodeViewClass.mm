//
//  VZFNodeViewClass.cpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#include "VZFNodeViewClass.h"
#import <objc/runtime.h>
#import "VZFUtils.h"

    
ViewClass::ViewClass():
_factory(nil){};

ViewClass::ViewClass(Class clz):
_factory(^(void){return [[clz alloc] init];}),
_identifier(class_getName(clz)){}

ViewClass::ViewClass(Class clz, SEL enter, SEL leave):
_factory(^(void ){return [[clz alloc] init];}),
_identifier(class_getName(clz)),
_didEnterReusePool(^(UIView* v){ [v performSelector:enter]; }),
_willLeaveReusePool(^(UIView* v){ [v performSelector:leave]; }){}

ViewClass::ViewClass(UIView *(^factory)(void), NSString* identifier, void(^enter)(UIView* v),void(^leave)(UIView* v)):
_factory([factory copy]),
_identifier([[identifier copy]UTF8String]),
_didEnterReusePool([enter copy]),
_willLeaveReusePool([leave copy])
{
#if DEBUG
  //  CKCAssertNil(objc_getClass(i.c_str()), @"You may not use a class name as the identifier; it would conflict with "
                    //"the constructor variant that takes a viewClass.");
#endif
}

const std::string & ViewClass::identifier() const{
    return _identifier;
}

UIView* ViewClass::createView() const{
    return _factory? _factory():nil;
}

bool ViewClass::hasView() const{
    return _factory;
}

