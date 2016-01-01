
#pragma once

#include "Macros.h"
#include "Property.h"

namespace flex {
    
    struct Inset {
        Float top;
        Float left;
        Float bottom;
        Float right;
        
        Inset() : Inset(0) {}
        Inset(Float all) : top(all), left(all), right(all), bottom(all) {}
        Inset(Float vertical, Float horizontal) : top(vertical), left(horizontal), bottom(vertical), right(horizontal) {}
        Inset(Float top, Float left, Float bottom, Float right) : top(top), left(left), bottom(bottom), right(right) {}
        
        Float width() const {
            return (left == Auto ? 0 : left) + (right == Auto ? 0 : right);
        }
        
        Float height() const {
            return (top == Auto ? 0 : top) + (bottom == Auto ? 0 : bottom);
        }
        
        Size size() const {
            return { width(), height() };
        }
        
        bool operator == (const Inset& inset) const {
            return top == inset.top && left == inset.left && bottom == inset.bottom && right == inset.right;
        }
        
        bool operator != (const Inset& inset) const {
            return !operator==(inset);
        }
    };
    
    inline std::string _insetToString(Inset inset) {
        if (inset.left == inset.right && inset.top == inset.bottom) {
            if (inset.left == inset.top) {
                return _sizeToString(inset.left);
            } else {
                return _sizeToString(inset.top) + ", " + _sizeToString(inset.left);
            }
        } else {
            return _sizeToString(inset.top) + ", " + _sizeToString(inset.left) + ", " + _sizeToString(inset.bottom) + ", " + _sizeToString(inset.right);
        }
    }
    
    template<>
    struct PropertyCast<Inset> {
        static std::string toString(const Inset& value) {
            return _insetToString(value);
        }
        
        static Inset fromString(const std::string& str) {
            NSMutableArray *array = [[NSString stringWithUTF8String:str.c_str()] componentsSeparatedByString:@","].mutableCopy;
            for (int i=0;i<array.count;i++) {
                array[i] = [array[i] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            }
            switch (array.count) {
                case 1:
                {
                    Float all = atof(((NSString*)array[0]).UTF8String);
                    return all;
                }
                case 2:
                {
                    Float ver = atof(((NSString*)array[0]).UTF8String);
                    Float hor = atof(((NSString*)array[1]).UTF8String);
                    return {ver, hor};
                }
                case 3:
                {
                    Float top = atof(((NSString*)array[0]).UTF8String);
                    Float left = atof(((NSString*)array[1]).UTF8String);
                    Float bottom = atof(((NSString*)array[2]).UTF8String);
                    return {top, left, bottom, 0};
                }
                default:
                {
                    Float top = atof(((NSString*)array[0]).UTF8String);
                    Float left = atof(((NSString*)array[1]).UTF8String);
                    Float bottom = atof(((NSString*)array[2]).UTF8String);
                    Float right = atof(((NSString*)array[3]).UTF8String);
                    return {top, left, bottom, right};
                }
            }
        }
    };
    
}
