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
        //使用右值，支持初始化赋值，减少拷贝
        UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs);
        UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs, VZLayerAttributes&& lattrs);
        ~UISpecs();
        
        const ViewClass& getViewClass() const;
        std::shared_ptr<const VZViewAttributes> getViewAttributes() const;
        std::shared_ptr<const VZLayerAttributes> getLayerAttributes() const;
    
    private:
        struct States{
        
            VZViewClass clz;
            std::shared_ptr<const VZViewAttributes> viewAttributes;
            std::shared_ptr<const VZLayerAttributes> layerAttributes;
        };
   
        std::shared_ptr<const States> state;
    };
}
