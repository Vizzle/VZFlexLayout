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
    
    //default
    ViewClass::ViewClass():_factory(nil),_identifier(nil){}
    
    //default
    ViewClass::ViewClass(Class clz):_factory([^(CGRect frame){return [[clz alloc] init];} copy]),_identifier(NSStringFromClass(clz).copy){}
    
    
    //default
    ViewClass::ViewClass(ViewFactory factory,NSString* identifier):_factory([factory copy]),_identifier(identifier.copy){}
    
//    ViewClass(Class clz):ViewClass((), NSStringFromClass(clz)){}
//    ViewClass(UIView *(^factory)(void),NSString* identifier):_factory([factory copy]),_identifier([[identifier copy]UTF8String]){}
    
//    ViewClass::ViewClass():ViewClass(nil){}
//    ViewClass::ViewClass(Class clz):ViewClass(clz,nil){}
//    ViewClass::ViewClass(Class clz, SEL reuse):ViewClass(clz,reuse,nil,nil){}
//    ViewClass::ViewClass(Class clz, SEL reuse, SEL enter, SEL leave):
//    _factory([^(void ){
//        return [[clz alloc] init];} copy]),
//    _identifier(class_getName(clz)),
//    _prepareForReuse([blockFromSEL(reuse) copy]),
//    _didEnterReusePool([blockFromSEL(enter) copy]),
//    _willLeaveReusePool([blockFromSEL(leave) copy]){
//    
//    
//        
//    
//    }
//    
//
//    ViewClass::ViewClass(UIView *(^factory)(void),
//                         NSString* identifier, void(^reuse)(UIView* v),
//                         void(^enter)(UIView* v),
//                         void(^leave)(UIView* v)):
//    _factory([factory copy]),
//    _identifier([[identifier copy]UTF8String]),
//    _prepareForReuse([reuse copy]),
//    _didEnterReusePool([enter copy]),
//    _willLeaveReusePool([leave copy]){}

    NSString* ViewClass::identifier() const{
        return _identifier;
    }

    void ViewClass::setIdentifier(NSString *identifier) {
        _identifier = identifier;
    }

    UIView* ViewClass::createView(CGRect frame) const{
        
        return _factory? _factory(frame):nil;
    }

    bool ViewClass::hasView() const{
        return _factory;
    
    }
    

    
//    VZFViewReuseBlock ViewClass::didEnterReusePool() const{
//        return [_didEnterReusePool copy];
//    }
//        
//    VZFViewReuseBlock ViewClass::willLeaveReusePool() const{
//        return [_willLeaveReusePool copy];
//    }
//    VZFViewReuseBlock ViewClass::prepareForReuse() const{
//        return [_prepareForReuse copy];
//    }
}
