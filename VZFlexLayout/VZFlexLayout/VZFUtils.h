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
        
        //(vector<T>) -> (lambda<filter>) -> (vector<T>)
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
        
        //(vector<T>) -> (lambda<map>) -> (vector<T>)
        template<typename Func>
        auto map(id<NSFastEnumeration> collection, Func &&func) -> std::vector<decltype(func(std::declval<id>()))>
        {
            std::vector<decltype(func(std::declval<id>()))> to;
            for (id obj in collection) {
                to.push_back(func(obj));
            }
            return to;
        }
    }


    
}