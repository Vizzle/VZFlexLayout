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
    
    struct ImageNodeSpecs{
    
        UIImage* image;
        NSString* imageUrl;
        UIImage* errorImage;
        UIViewContentMode contentMode;
        
        VZFBlockAction* completion;
        id context;

        const ImageNodeSpecs copy() const{
            return {[image copy], [imageUrl copy], [errorImage copy],contentMode, completion, context};
        }
        
        bool operator == (const ImageNodeSpecs &other) const {
            return (image == other.image
                    && contentMode == other.contentMode
                    && imageUrl == other.imageUrl
                    && completion == other.completion
                    && context == other.context);
        }
        
        size_t hash() const;
    };

}
