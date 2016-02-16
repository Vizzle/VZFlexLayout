//
//  VZFNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFMacros.h"
#import "VZFNodeLayout.h"
#import "VZFlexNode.h"
#import "VZFNodeInternal.h"



@interface VZFlexNode()

@end

@implementation VZFNode
{
    
}

@synthesize flexNode = _flexNode;

+ (id)initialState{
    return nil;
}

+(instancetype)nodeWithUISpecs:(const VZUISpecs &)specs{
    
    return [[self alloc] initWithUISpecs:specs];
}



+ (instancetype)new
{
    return [self nodeWithUISpecs:{}];
}

- (instancetype)initWithUISpecs:(const VZUISpecs& )specs{
    self = [super init];
    if (self) {
        
        _specs = specs;
        _flexNode = [VZFNodeUISpecs flexNodeWithAttributes:_specs.flex];
        _flexNode.name = [NSString stringWithUTF8String:specs.name.c_str()];
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz{
    
    [_flexNode layout:sz];
    VZFNodeLayout layout = { _flexNode.resultFrame.size,
                             _flexNode.resultFrame.origin,
                             _flexNode.resultMargin
    };
    return layout;
}

- (NSString *)description {
    return self.flexNode.description;
}

@end
