//
//  VZSizeRange.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/14.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFSizeRange.h"
#import "VZFNodeSpecs.h"
#import "VZFValue.h"


namespace VZ {
    CGSize containerSize(VZFSizeRange type, CGSize givenSize){
        
        if (type == VZFlexibleSizeWidthAndHeight) {
            return (CGSize){FlexValue::Auto,FlexValue::Auto};
        }
        else if (type == VZFlexibleSizeHeight){
            return (CGSize){givenSize.width,FlexValue::Auto};
        }
        else if (type == VZFlexibleSizeWidth){
            return (CGSize){FlexValue::Auto,givenSize.height};
        }
        else if (type == VZFlexibleSizeNone){
            return givenSize;
        }
        else{
            return givenSize;
        }
    }
}



