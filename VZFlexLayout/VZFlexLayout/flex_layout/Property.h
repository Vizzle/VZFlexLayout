
#pragma once

#include "Macros.h"
#include "Enum.h"

#include <string>
#include <vector>
#include <unordered_map>

namespace flex {
    
    struct BaseProperty {
        std::string name;
        std::string description;
        std::string category;
        int offset;
        
        BaseProperty(const std::string& name, int offset, const std::string& category, const std::string& description) : name(name), offset(offset), category(category), description(description) {}
        
        virtual std::string getValue(void *obj) const = 0;
        virtual bool setValue(void *obj, const std::string& value) const = 0;
        virtual bool isDefault(void *obj) const = 0;
        virtual bool isEqual(void *value1, void *value2) const = 0;
        virtual bool isEnum() const = 0;
        virtual bool isBool() const = 0;
        virtual const std::vector<std::string>& getConstants() const = 0;
    };
    
    template <typename Type>
    struct PropertyCast {
        static std::string toString(const Type& value);
        static Type fromString(const std::string& str);
    };
    
    template <typename Type, bool IsEnum = false>
    struct Property : BaseProperty {
        Type defaultValue;
        std::vector<std::string> constants;
        std::unordered_map<std::string, Type> constantsMap;
        
        Property(const std::string& name, int offset, Type defaultValue, const std::string& category = "", const std::string& description = "", const std::unordered_map<std::string, Type>& constantsMap = {}) : BaseProperty(name, offset, category, description), defaultValue(defaultValue), constantsMap(constantsMap) {
            for (auto& kv : constantsMap) {
                constants.push_back(kv.first);
            }
        }
        
        bool isDefault(void *obj) const {
            return *(Type*)(((char*)obj) + offset) == defaultValue;
        }
        
        bool isEqual(void *value1, void *value2) const {
            return *(Type*)(((char*)value1) + offset) == *(Type*)(((char*)value2) + offset);
        }
        
        std::string getValue(void *obj) const {
            Type value = *(Type*)(((char*)obj) + offset);
            for (auto& kv : constantsMap) {
                if (kv.second == value) {
                    return kv.first;
                }
            }
            return PropertyCast<Type>::toString(value);
        }
        
        bool setValue(void *obj, const std::string& str) const {
            Type value;
            if (str.empty()) {
                value = defaultValue;
            }
            else {
                auto it = constantsMap.find(str);
                if (it != constantsMap.end()) {
                    value = it->second;
                }
                else {
                    value = PropertyCast<Type>::fromString(str);
                }
            }
            
            if (!(*(Type*)(((char*)obj) + offset) == value)) {
                *(Type*)(((char*)obj) + offset) = value;
                return true;
            }
            return false;
        }
        
        bool isEnum() const {
            return false;
        }
        
        bool isBool() const {
            return std::is_same<Type, bool>::value;
        }
        
        const std::vector<std::string>& getConstants() const {
            return constants;
        }
    };
    
    template <typename Type>
    struct Property<Type, true> : BaseProperty {
        Type defaultValue;
        
        Property(const std::string& name, int offset, Type defaultValue, const std::string& category = "", const std::string& description = "") : BaseProperty(name, offset, category, description), defaultValue(defaultValue) {}
        
        bool isDefault(void *obj) const {
            return *reinterpret_cast<Type*>(((char*)obj) + offset) == defaultValue;
        }
        
        bool isEqual(void *value1, void *value2) const {
            return *(Type*)(((char*)value1) + offset) == *(Type*)(((char*)value2) + offset);
        }
        
        std::string getValue(void *obj) const {
            Type value = *(Type*)(((char*)obj) + offset);
            return GetEnum<Type>::get()->getName(value);
        }
        
        bool setValue(void *obj, const std::string& name) const {
            Type value;
            if (name.empty()) {
                value = defaultValue;
            }
            else {
                value = GetEnum<Type>::get()->template getValue<Type>(name);
            }
            
            if (!(*(Type*)(((char*)obj) + offset) == value)) {
                *(Type*)(((char*)obj) + offset) = value;
                return true;
            }
            return false;
        }
        
        bool isEnum() const {
            return true;
        }
        
        bool isBool() const {
            return false;
        }
        
        const std::vector<std::string>& getConstants() const {
            return GetEnum<Type>::get()->getNames();
        }
    };
    
    inline std::string _floatToString(Float value) {
        std::string s = std::to_string(value);
        int i = (int)s.length()-1;
        for (;i>=0;i--) {
            if (s[i] != '0') {
                break;
            }
        }
        if (i >= 0 && s[i] == '.') i--;
        return s.substr(0, i + 1);
    }
    
    inline std::string _sizeToString(Float size) {
        if (size == Undefined) {
            return "";
        } else if (size == Infinite) {
            return "infinite";
        } else if (size == Auto) {
            return "auto";
        } else if (size == Content) {
            return "content";
        } else {
            return _floatToString(size);
        }
    }
    
    template<>
    struct PropertyCast<Float> {
        static std::string toString(const Float& value) {
            return _floatToString(value);
        }
        
        static Float fromString(const std::string& str) {
            return atof(str.c_str());
        }
    };
    
    template<>
    struct PropertyCast<std::string> {
        static std::string toString(const std::string& value) {
            return value;
        }
        
        static std::string fromString(const std::string& str) {
            return str;
        }
    };
    
    template<>
    struct PropertyCast<bool> {
        static std::string toString(const bool& value) {
            return value ? "true" : "false";
        }
        
        static bool fromString(const std::string& str) {
            return str == "true";
        }
    };
    
}
