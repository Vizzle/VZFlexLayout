//
//  VZFNodeViewClass.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <unordered_map>


//typedef std::unordered_map<VZ::VZFNodeAttribute, id> VZViewAttributeMap;
namespace VZ {
    
    struct VZFNodeViewConfig{
    
        VZFNodeViewConfig(){};
//        VZFNodeViewConfig(const VZViewAttributeMap &attrs){};
        ~VZFNodeViewConfig(){};
    
    };
}