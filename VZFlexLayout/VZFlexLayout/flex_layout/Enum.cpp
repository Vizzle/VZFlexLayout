
#include "Enum.h"
#include "StringHelper.h"

#include <cstdlib>

namespace flex {
    
    std::vector<std::shared_ptr<Enum>> Enum::enums;
    
    const Enum* Enum::registerEnum(const char* str) {
        auto en = std::make_shared<Enum>();
        auto items = StringHelper::Split(StringHelper::RemoveSpaces(str), ',');
        int num = 0;
        for (auto& i : items){
            std::string name;
            if ((int)i.find('=') >= 0){
                auto kv = StringHelper::Split(i, '=');
                name = kv[0];
                num = atoi(kv[1].c_str());
            }
            else{
                name = i;
            }
            en->names.push_back(name);
            en->nameValueMap.insert(std::make_pair(name, num));
            num++;
        }
        
        std::unordered_map<int64_t, std::string> map2;
        for (auto& i : en->nameValueMap){
            en->valueNameMap.insert(std::make_pair(i.second, i.first));
        }
        
        enums.push_back(en);
        return enums.back().get();
    }
    
}
