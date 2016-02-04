//
//  VZFNodeUISpecs.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeUISpecs.h"

VZ::UISpecs::UISpecs(){};

VZ::UISpecs::UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs)
            :UISpecs(std::move(clz),std::move(vattrs),{}){};

VZ::UISpecs::UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs, VZLayerAttributes&& lattrs)
{
    
}