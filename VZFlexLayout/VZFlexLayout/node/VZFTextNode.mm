//
//  VZFTextNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNode.h"
#import "VZFMacros.h"

@implementation VZFTextNode

@synthesize specs = _specs;
@synthesize textSpecs = _textSpecs;

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)newWithNodeSpecs:(const NodeSpecs &)specs TextAttributes:(const VZ::TextNodeSpecs &)textSpecs{

    VZFTextNode* textNode = [super newWithView:[UILabel class] NodeSpecs:specs];
    
    if (textNode) {
        textNode -> _specs = specs;
        textNode -> _textSpecs = textSpecs.copy();
    }
    return textNode;
}

@end
