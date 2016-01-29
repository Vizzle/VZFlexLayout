//
//  VZFNodeViewClass.hpp
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <string>

namespace VZ {
    
    struct ViewClass{
        
        ViewClass();
        ViewClass(Class clz);
        ViewClass(UIView*(*factory)(void));
        
        const std::string &getIdentifier() const { return identifier; }
        UIView* createView() const{ return factory?factory():nil; }
        bool hasView() const {return factory; }
        
    private:
        UIView* (^factory)();
        std::string identifier;
    };
}

namespace std {
    template<>
    struct hash<VZ::ViewClass>{
        size_t operator()(const VZ::ViewClass &cl) const
        {
            return hash<std::string>()(cl.getIdentifier());
        }
    };
}




