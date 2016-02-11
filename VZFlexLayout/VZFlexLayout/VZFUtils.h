//
//  VZFUtils.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

#import <algorithm>
#import <functional>
#import <type_traits>
#import <vector>

namespace VZ {
    namespace F{
        
        //filter: (vector<T>) -> (vector<T>)
        template<typename T, typename Func>
        auto filter(const T& container, Func && lambda) -> std::vector<typename T::value_type>
        {
            std::vector<typename T::value_type> to;
            for(auto obj : container){
                if(lambda(obj)){
                    to.push_back(obj);
                }
            }
            
            return to;
        }
    }

    
}