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
@synthesize flexNode = _flexNode;

+ (instancetype)nodeWithUISpecs:(const VZUISpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)imageNodeWithSpecs:(const VZUIImageNodeSpecs& )specs{
    
    //check the specs
    VZFImageNode* imageNode = [super nodeWithUISpecs:{}];
    
    if (imageNode) {
        imageNode -> _specs = specs;
        imageNode -> _flexNode = [VZFNodeUISpecs flexNodeWithAttributes:specs.flex];
        imageNode -> _flexNode.name = [[NSString alloc]initWithUTF8String:specs.name.c_str()];
    }
    return imageNode;
    
}

@end
