//
//  FNViewAttribute.h
//  FNode
//
//  Created by Sleen on 15/12/18.
//  Copyright © 2015年 O2O. All rights reserved.
//

#include "Macros.h"

#include <string>
#include <unordered_map>

#include <objc/runtime.h>

namespace flex {
    
    struct FNViewAttribute {
        std::string identifier;
        void (^setter)(id view, id value);
        
        FNViewAttribute(SEL setter) : identifier(sel_getName(setter)), setter(^(id view, id value){
            [view performSelector:setter withObject:value];
        }) {}
        FNViewAttribute(const std::string& identifier, void (^setter)(id view, id value)) : identifier(identifier), setter(setter) {}
        
        bool operator==(const FNViewAttribute &attr) const { return identifier == attr.identifier; }
    };

}

namespace std {
    template<>
    struct hash<flex::FNViewAttribute>{
        size_t operator()(const flex::FNViewAttribute &attr) const {
            return hash<std::string>()(attr.identifier);
        }
    };
}

namespace flex {
    
#if FLEX_IOS
    using OSGestureRecognizer = UIGestureRecognizer;
    using OSTapGestureRecognizer = UITapGestureRecognizer;
#elif FLEX_OSX
    using OSGestureRecognizer = NSGestureRecognizer;
    using OSTapGestureRecognizer = NSClickGestureRecognizer;
#endif

    using FNViewAttributeMap = std::unordered_map<FNViewAttribute, id>;

    FNViewAttributeMap::value_type GestrueAttribute(Class cls, void(^block)(id sender));

    inline FNViewAttributeMap::value_type TapGestrue(void(^block)(id sender)) {
        return GestrueAttribute([OSTapGestureRecognizer class], block);
    }
    
}
