//
//  VZFNodeUISpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUIAttributes.h"

namespace VZ {
    
    struct UISpecs{
        
        UISpecs();
        //使用右值，支持初始化赋值
        UISpecs(VZUISpecs&& spec);
        ~UISpecs();
        
        const std::shared_ptr<const VZUISpecs> getSpecs() const;
    
    private:
        struct State{
            std::shared_ptr<const VZUISpecs> specs;
        };
   
        std::shared_ptr<const State> state;
    };
}
