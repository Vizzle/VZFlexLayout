
#pragma once

#include "Macros.h"
#include "Property.h"

namespace flex {
    
    enum class LengthType {
        Enum,
        Point,
        Pixel,
        Percent,
    };
    
    struct Length {
        Float value;
        LengthType type;
        
        Length() : Length(0) {}
        Length(Float value, LengthType type) : value(value), type(type) {}
        Length(Float value) : value(value), type(value >= 0 ? LengthType::Point : LengthType::Enum) {}
        Length(const Length& l) : value(l.value), type(l.type) {}
        
        bool isAuto() const { return type == LengthType::Enum && value == Auto; }
        bool isAbsolute() const { return type == LengthType::Point || type == LengthType::Pixel; }
        bool isPercent() const { return type == LengthType::Percent; }
        Float absoluteValue() const;
        bool operator == (const Length& l) const {
            return value == l.value && type == l.type;
        }
        bool operator != (const Length& l) const {
            return !operator==(l);
        }
        Length& operator = (const Length& l) {
            value = l.value;
            type = l.type;
            return *this;
        }
    };
    
    template<>
    struct PropertyCast<Length> {
        static std::string toString(const Length& value) {
            if (value.type == LengthType::Percent) {
                return _floatToString(value.value * 100) + "%";
            }
            else if (value.type == LengthType::Pixel) {
                return _floatToString(value.value) + "px";
            }
            else {
                return _floatToString(value.value);
            }
        }
        
        static Length fromString(const std::string& str) {
            if (str.back() == '%') {
                return Length(atof(str.substr(0, str.length()-1).c_str()) / 100, LengthType::Percent);
            }
            else if (str.length() > 2 && str.substr(str.length() - 2) == "px") {
                return Length(atof(str.substr(0, str.length()-2).c_str()), LengthType::Pixel);
            }
            else {
                return atof(str.c_str());
            }
        }
    };
    
    inline Length operator "" _px(unsigned long long value) {
        return { (Float)value, LengthType::Pixel };
    }
    
    inline Length operator "" _px(long double value) {
        return { (Float)value, LengthType::Pixel };
    }
    
    inline Length operator "" _cent(unsigned long long value) {
        return { (Float)value, LengthType::Percent };
    }
    
    inline Length operator "" _cent(long double value) {
        return { (Float)value, LengthType::Percent };
    }
    
}
