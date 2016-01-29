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
    ViewAttributes _viewConfiguration;
    LayerAttributes _layerConfiguration;
    FlexAttributes _flexConfiguration;
}

+ (id)initialState{
    return nil;
}

+(instancetype)newWithClass:(const ViewClass &)clz
             ViewAttributes:(const ViewAttributes &)view
             FlexAttributes:(const FlexAttributes &)flex{

    return [self newWithClass:{} ViewAttributes:view LayerAttributes:{} FlexAttributes:flex];
}

+(instancetype)newWithClass:(const ViewClass &)clz
             ViewAttributes:(const ViewAttributes &)view
            LayerAttributes:(const LayerAttributes &)layer
             FlexAttributes:(const FlexAttributes &)flex{
    
    return [[self alloc] initWithView:clz ViewAttributes:view LayerAttributes:layer FlexAttributes:flex];
}

+ (instancetype)new
{
    return [self newWithClass:{} ViewAttributes:{} FlexAttributes:{}];
}

- (instancetype)initWithView:(const ViewClass& )clz
              ViewAttributes:(const ViewAttributes &)view
             LayerAttributes:(const LayerAttributes &)layer
              FlexAttributes:(const FlexAttributes &)flex
{
    self = [super init];
    if (self) {
        
        _node = [VZFlexNode new];
        _viewConfiguration = view;
        _layerConfiguration = layer;
        _flexConfiguration = flex;
        
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
