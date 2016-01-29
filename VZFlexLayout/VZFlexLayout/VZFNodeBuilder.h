//
//  VZFNodeBuilder.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

#include <functional>

//写一个语法糖
namespace VZ {
    template<typename T>
    struct NodeBuilder{
        T *node;
        NodeBuilder(std::function<void(T*)> builder){
        
            node = [[T alloc] init];
            builder(node);
        }
        operator T*() const { return node; }
    };
}

#define BUILD_NODE(T) (T*)(NodeBuilder<T>)[=](NodeType* _)
