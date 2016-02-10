//
//  VZFNodeUISpecs.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeUISpecs.h"

VZ::UISpecs::~UISpecs(){};
VZ::UISpecs::UISpecs(){};
VZ::UISpecs::UISpecs(VZUISpec&& spec){
    
    auto t = new State{
        .spec = std::make_shared<VZUISpec>(std::move(spec))
    };
    state.reset(t);
}
const std::shared_ptr<const VZUISpec>VZ::UISpecs:: getSpec() const {
    return state->spec;
}



