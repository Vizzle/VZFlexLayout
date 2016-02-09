//
//  VZFNodeFlexAttributes.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#pragma once

namespace VZ
{
    struct FlexAttribute{
        
        float width;
        float height;
        float marginLeft;
        float marginRight;
        float marginTop;
        float marginBottom;
        
        float flexGrow;
        float flexShrink;
    };
    
//    FlexAttribute defaultFlexAttributes(){
//        return {
//            .width = 0,
//            .height = 0,
//            .marginLeft = 0,
//            .marginRight = 0,
//            .marginTop = 0,
//            .marginBottom = 0,
//            .flexGrow = 1,
//            .flexShrink = 0
//        };
//    }
}

typedef VZ::FlexAttribute VZFlexAttributes;