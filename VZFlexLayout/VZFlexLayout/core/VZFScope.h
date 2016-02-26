//
//  VZFStateScope.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/19.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace VZ {

    /**
     *  Node内部的State是封闭的，StateScope用来让Node在类方法内获取state
     */
    struct Scope{
        
        Scope(Class clz, id scopeIdentifier=nil, id(^initialStateCreator)(void)=nil);
        ~Scope();
        
        id state() const;
        
    private:
        Scope(const Scope& ) = delete;
        Scope& operator=(const Scope& ) = delete;
        id _state;
        id _scopeIdentifier;
        Class _nodeClass;

    };
}







