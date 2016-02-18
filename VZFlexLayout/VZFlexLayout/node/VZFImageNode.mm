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

@synthesize specs = _specs;
@synthesize imagesSpecs = _imageSpecs;
@synthesize flexNode = _flexNode;

+ (instancetype)nodeWithUISpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)imageNodeWithSpecs:(const NodeSpecs &)specs ImageSpecs:(const ImageNodeSpecs &)imageSpecs
{
    VZFImageNode* imageNode = [super nodeWithView:[UIImageView class] Specs:specs];    
    if (imageNode) {
        imageNode -> _imageSpecs = imageSpecs.copy();
    }
    return imageNode;
    
}

@end
