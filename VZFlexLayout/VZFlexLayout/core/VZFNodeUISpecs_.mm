//
//  VZFNodeUISpecs.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeUISpecs.h"

VZ::UISpecs::~UISpecs(){};
VZ::UISpecs::UISpecs(){
    auto t = new State{
        .specs = std::make_shared<VZUISpecs>()
    };
    state.reset(t);
};
VZ::UISpecs::UISpecs(VZUISpecs&& specs){
    
    auto t = new State{
        .specs = std::make_shared<VZUISpecs>(std::move(specs))
    };
    state.reset(t);
}
const std::shared_ptr<const VZUISpecs>VZ::UISpecs:: getSpecs() const {
    return state->specs;
}



