//
//  VZFImageNodeSpec.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFActionWrapper.h"


namespace VZ {
    
    struct IndicatorNodeSpecs {
        UIColor *color;
        
        
        const IndicatorNodeSpecs copy() const{
            return {color};
        }
        
        bool operator == (const IndicatorNodeSpecs &other) const {
            return (Hash::_ObjectsEqual(color, other.color));
        }
        
        size_t hash() const;
    };
    
}
