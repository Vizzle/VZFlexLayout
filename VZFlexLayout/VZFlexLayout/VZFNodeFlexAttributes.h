//
//  VZFNodeFlexAttributes.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/3.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace VZ
{
    struct FlexAttribute{
        
        float width;
        float height;
        float marginLeft;
        float marginRight;
        float marginTop;
        float marginBottom;
        bool flexGrow;
        bool flexShrink;
    };
}

typedef VZ::FlexAttribute VZFlexAttributes;