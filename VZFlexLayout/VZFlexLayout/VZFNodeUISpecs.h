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
        UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs);
        UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs, VZLayerAttributes&& lattrs);
    
    };    
}
