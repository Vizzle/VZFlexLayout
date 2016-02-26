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
        UIViewContentMode contentMode;

        const ImageNodeSpecs copy() const{
            return {[image copy] , contentMode };
        }
        
        bool operator == (const ImageNodeSpecs &other) const {
            return (image == other.image && contentMode == other.contentMode);
        }
        
        size_t hash() const;
    };

}

typedef VZ::ImageNodeSpecs VZImageSpecs;