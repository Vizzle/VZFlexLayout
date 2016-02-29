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
        ViewClass(Class clz, SEL enter, SEL leave);
        ViewClass(UIView *(^factory)(void), NSString* identifier, void(^enter)(UIView* v)= nil,void(^leave)(UIView* v)  = nil);

        const std::string &identifier() const;
        UIView* createView() const;
        bool hasView() const;
        
        bool operator==(const ViewClass &other) const { return other.identifier() == _identifier; }
        
    private:
        std::string _identifier;
        UIView *(^_factory)(void);
        void(^_didEnterReusePool)(UIView* v);
        void(^_willLeaveReusePool)(UIView* v);
    };
}

typedef VZ::ViewClass ViewClass;

//hash<ViewClass>
namespace std {
    template<>
    struct hash<VZ::ViewClass>{
        size_t operator()(const VZ::ViewClass &cl) const
        {
            return hash<std::string>()(cl.identifier());
        }
    };
}




