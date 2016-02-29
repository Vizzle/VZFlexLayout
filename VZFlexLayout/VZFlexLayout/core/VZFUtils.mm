//
//  VZFUtils.c
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFUtils.h"

namespace VZ{
    namespace Helper{
        std::string stringFromPointer(const void* ptr){
            char buf[64];
            snprintf(buf, sizeof(buf), "%p", ptr);
            return buf;
        }
    }
}