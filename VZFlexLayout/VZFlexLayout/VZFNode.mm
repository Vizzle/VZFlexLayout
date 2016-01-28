//
//  VZFNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFMacros.h"
#import "VZFNodeLayout.h"

@implementation VZFNode
{
    VZFNodeInternal* _node;
    ViewAttributes _viewConfiguration;
    LayerAttributes _layerConfiguration;
}

+ (id)initialState{
    return nil;
}

+(instancetype)newWithClass:(Class)clz
             ViewAttributes:(const ViewAttributes &)view
             FlexAttributes:(const VZFlexAttributes &)flex{

    return [self newWithClass:clz ViewAttributes:view LayerAttributes:{} FlexAttributes:flex];
}

+(instancetype)newWithClass:(Class)clz
             ViewAttributes:(const ViewAttributes &)view
            LayerAttributes:(const LayerAttributes &)layer
             FlexAttributes:(const VZFlexAttributes &)flex{
    
    VZFNode* fnode = [VZFNode new];
    fnode -> _node = [VZFNodeInternal new];
    return fnode;

}

+ (instancetype)new
{
    return [self newWithClass:nil ViewAttributes:{} FlexAttributes:{}];
}

- (instancetype)init
{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

- (void)updateState:(id (^)(id))updateBlock{

    
}

- (VZFNodeLayout)layoutThatFits:(CGSize)sz{
    return {};
}


@end
