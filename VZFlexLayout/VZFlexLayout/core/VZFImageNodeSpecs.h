//
//  VZFImageNodeSpec.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"

namespace VZ {
    
    struct ImageNodeSpecs{
    
        UIImage* image;
        
        const ImageNodeSpecs copy() const{
            return { [image copy] };
        }
        
        bool operator == (const ImageNodeSpecs &other) const {
            return (image == other.image);
        }
        
        size_t hash() const;
    };

}

typedef VZ::ImageNodeSpecs ImageNodeSpecs;