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

@implementation VZFNode
{
    VZFlexNode* _node;
//    ViewAttributes _viewConfiguration;
//    LayerAttributes _layerConfiguration;
//    FlexAttributes _flexConfiguration;
}

+ (id)initialState{
    return nil;
}

+(instancetype)nodeWithSpecs:(const VZ::UISpecs &)specs FlexAttributes:(const VZ::FlexAttribute &)attr{
    
    return  [[self alloc] initWithSpecs:specs FlexAttributes:attr];
}


+ (instancetype)new
{
    return [self nodeWithSpecs:{} FlexAttributes:{}];
}

- (instancetype)initWithSpecs:(const VZ::UISpecs& )specs FlexAttributes:(const VZ::FlexAttribute &)attr
{
    self = [super init];
    if (self) {
        
        _node = [VZFlexNode new];
        
    }
    return self;
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)updateState:(id (^)(id))updateBlock{


}

- (void)computeLayoutThatFits:(CGSize)sz{
    
    [_node layout:sz];
//    return {};
}

- (void)render{

    [_node renderRecursively];
}


@end
