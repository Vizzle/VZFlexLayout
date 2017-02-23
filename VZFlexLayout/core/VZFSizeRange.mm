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
            return CGSizeMake(FlexValue::Auto(),FlexValue::Auto());
        }
        else if (type == VZFlexibleSizeHeight){
            return  CGSizeMake(givenSize.width,FlexValue::Auto());
        }
        else if (type == VZFlexibleSizeWidth){
            return CGSizeMake(FlexValue::Auto(),givenSize.height);
        }
        else if (type == VZFlexibleSizeNone){
            return givenSize;
        }
        else{
            return givenSize;
        }
    }
}



