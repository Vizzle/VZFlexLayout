//
//  VZFImageNodeSpec.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFImageNodeSpecs.h"

namespace VZ {
    
    size_t ImageNodeSpecs::hash() const{
    
        return [image hash];
    }
}