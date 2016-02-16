//
//  VZFNodeViewClass.hpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <string>
#import <functional>

namespace VZ {
    
    struct ViewClass{
        
        ViewClass():factory(nil){};
        ViewClass(Class clz):factory(^{return [[clz alloc] init];}){}
        ViewClass(UIView*(^function)(void)):factory(function){};
        
        const std::string &getIdentifier() const { return identifier; }
        UIView* createView() const{ return factory?factory():nil; }
        bool hasView() const {return factory; }
        
    private:
        
//        std::function<UIView* (void)> fp;
        UIView* (^factory)();
        std::string identifier;
    };
}

typedef VZ::ViewClass VZViewClass;

//hash<ViewClass>
namespace std {
    template<>
    struct hash<VZ::ViewClass>{
        size_t operator()(const VZ::ViewClass &cl) const
        {
            return hash<std::string>()(cl.getIdentifier());
        }
    };
}




