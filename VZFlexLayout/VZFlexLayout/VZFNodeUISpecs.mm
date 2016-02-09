//
//  VZFNodeUISpecs.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeUISpecs.h"

VZ::UISpecs::UISpecs(){
   
    auto t = new States{
        
        .clz = [UIView class],
        .viewAttributes = std::make_shared<VZViewAttributes>(),
        .layerAttributes = std::make_shared<VZLayerAttributes>()
    };
    this->state.reset(t);
    
};

VZ::UISpecs::UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs)
            :UISpecs(std::move(clz),std::move(vattrs),{}){};

VZ::UISpecs::UISpecs(VZViewClass&& clz, VZViewAttributes&& vattrs, VZLayerAttributes&& lattrs)
{
    auto t = new States{
        
        .clz = std::move(clz),
        .viewAttributes = std::make_shared<VZViewAttributes>(std::move(vattrs)),
        .layerAttributes = std::make_shared<VZLayerAttributes>(std::move(lattrs))
    };
    this->state.reset(t);
}

VZ::UISpecs::~UISpecs(){};

const VZ::ViewClass& VZ::UISpecs::getViewClass() const  {

    return state->clz;
}
std::shared_ptr<const VZViewAttributes> VZ::UISpecs::getViewAttributes() const{
    return state ->viewAttributes;
}
std::shared_ptr<const VZLayerAttributes> VZ::UISpecs::getLayerAttributes() const{
    return state->layerAttributes;
}