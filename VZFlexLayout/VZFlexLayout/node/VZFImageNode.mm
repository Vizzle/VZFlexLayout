//
//  VZFImageNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFImageNode.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFMacros.h"

@implementation VZFImageNode


@synthesize imagesSpecs = _imageSpecs;

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)newWithNodeSpecs:(const NodeSpecs &)specs ImageAttributes:(const ImageNodeSpecs &)imageSpecs
{
    VZFImageNode* imageNode = [super newWithView:[UIImageView class] NodeSpecs:specs];
    if (imageNode) {
        imageNode -> _imageSpecs = imageSpecs.copy();
        
        __weak typeof(imageNode) weakNode = imageNode;
        imageNode.flexNode.measure = ^(CGSize constraintedSize) {
            __strong typeof(weakNode) strongNode = weakNode;
            if (!strongNode) return CGSizeZero;
            
            VZ::ImageNodeSpecs imageSpecs = strongNode.imagesSpecs;
            return imageSpecs.image ? imageSpecs.image.size : CGSizeZero;
        };
    }
    return imageNode;
    
}

@end
