//
//  VZFNodeUISpecs.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUIAttributes.h"
#import "VZFNodeFlexAttributes.h"
#import "VZFNodeViewClass.h"

namespace VZ {
    
    struct UISpecs{
        
        UISpecs();
        //使用右值，支持初始化赋值
        UISpecs(VZUISpec&& spec);
        ~UISpecs();
        
        const std::shared_ptr<const VZUISpec> getSpec() const;
    
    private:
        struct State{
            std::shared_ptr<const VZUISpec> spec;
        };
   
        std::shared_ptr<const State> state;
    };
}
