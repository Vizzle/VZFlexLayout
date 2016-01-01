
#pragma once

#include <string>
#include <vector>
#include <unordered_map>

#define REFLECT_ENUM(typeName, ...)                                     \
enum class typeName{                                                    \
    __VA_ARGS__                                                         \
};                                                                      \
                                                                        \
template<>                                                              \
struct GetEnum<typeName> {                                              \
    static const Enum* get() {                                          \
        static const Enum* en = Enum::registerEnum(#__VA_ARGS__);       \
        return en;                                                      \
    }                                                                   \
};                                                                      \

namespace flex {
    
    class Enum {
    public:
        
        const std::vector<std::string>& getNames() const {
            return names;
        }
        
        template<typename EnumType>
        EnumType getValue(const std::string name) const {
            static_assert(std::is_enum<EnumType>::value, "enum class needed");
            return (EnumType)nameValueMap[name];
        }
        
        template<typename EnumType>
        std::string getName(EnumType value) const {
            static_assert(std::is_enum<EnumType>::value, "enum class needed");
            return valueNameMap[(int64_t)value];
        }
        
        static const Enum* registerEnum(const char* str);
        
    private:
        std::vector<std::string> names;
        mutable std::unordered_map<std::string, int64_t> nameValueMap;
        mutable std::unordered_map<int64_t, std::string> valueNameMap;
//        static std::unordered_map<std::string, Enum> enums;
        static std::vector<std::shared_ptr<Enum>> enums;
    };
    
    template<typename Type>
    struct GetEnum {
        static const Enum *get();
    };
    
}
