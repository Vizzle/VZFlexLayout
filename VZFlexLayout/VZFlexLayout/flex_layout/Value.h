
#pragma once

#include <type_traits>

namespace flex {
    
    namespace internal {
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
    using Value = internal::_Value<Type, defaultValue, std::is_class<Type>::value>;
    
}
