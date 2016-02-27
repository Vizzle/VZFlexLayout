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

namespace VZ {
    
    
    ViewClass::ViewClass():
    _factory(nil){};
    
    ViewClass::ViewClass(Class clz):
    _factory(^{return [[clz alloc] init];}),
    _identifier(class_getName(clz)){}
    
    ViewClass::ViewClass(Class clz, SEL enter, SEL leave):
    _factory(^{return [[clz alloc] init];}),
    _identifier(class_getName(clz)),
    _didEnterReusePool(^(UIView* v){ [v performSelector:enter]; }),
    _willLeaveReusePool(^(UIView* v){ [v performSelector:enter]; }){}
    
    ViewClass::ViewClass(UIView *(*factory)(void),void(^enter)(UIView* v),void(^leave)(UIView* v)):
    _factory(^(void){
        UIView* v = factory();
        return v;
    }),
    _identifier(Helper::stringFromPointer((const void* )factory)),
    _didEnterReusePool([enter copy]),
    _willLeaveReusePool([leave copy]){}
    
    
    ViewClass::ViewClass(const std::string &i,
                        UIView *(^fact)(void),
                      void (^enter)(UIView *),
                      void (^leave)(UIView *)):
                    _identifier(i),
                    _factory(fact),
                    _didEnterReusePool(enter),
                    _willLeaveReusePool(leave)
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

}