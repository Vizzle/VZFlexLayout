//
//  VZFValue.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/11.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#include <type_traits>

namespace VZ{
    
    namespace Internal{
        
        template<typename Type, const Type& defaultValue, bool isClass = false>
        struct _Value {
            Type value;
            _Value() : value(defaultValue) {}
            _Value(Type value) : value(value) {}
            template<typename... Args>
            _Value(Args... args) : value(args...) {
                static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
            }
            operator Type() const { return value; }
            bool isDefault() const { return value == defaultValue; }
        };
        
        template<typename Type, const Type& defaultValue>
        struct _Value <Type, defaultValue, true> : public Type {
            _Value() : Type(defaultValue) {}
            _Value(Type value) : Type(value) {}
            template<typename... Args>
            _Value(Args... args) : Type(args...) {
                static_assert(std::is_constructible<Type, Args...>::value, "there is no suitable constructor");
            }
            operator Type() const { return *this; }
            bool isDefault() const { return *this == defaultValue; }
        };
        
    }

    template<typename Type, const Type& defaultValue>
    using Value = Internal::_Value<Type, defaultValue, std::is_class<Type>::value>;
}
