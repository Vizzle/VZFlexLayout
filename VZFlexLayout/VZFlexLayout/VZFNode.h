//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeAttribute.h"
#import "VZFNodeLayout.h"
#import "VZFNodeViewClass.h"
#import <unordered_map>

typedef std::unordered_map<VZ::UIAttribute<UIView>, id> ViewAttributes;
typedef std::unordered_map<VZ::UIAttribute<CALayer>, id> LayerAttributes;
typedef VZ::ViewClass ViewClass;
typedef VZ::FlexAttribute FlexAttributes;
typedef VZ::NodeLayout NodeLayout;

@interface VZFNode : NSObject

+(instancetype)newWithClass:(const ViewClass &)clz
            ViewAttributes:(const ViewAttributes &)view
             FlexAttributes:(const FlexAttributes &)flex;

+(instancetype)newWithClass:(const ViewClass &)clz
             ViewAttributes:(const ViewAttributes &)view
            LayerAttributes:(const LayerAttributes &)layer
             FlexAttributes:(const FlexAttributes &)flex;

+ (id)initialState;

- (void)updateState:(id(^)(id))updateBlock;

- (void)computeLayoutThatFits:(CGSize)sz;

- (void)render;



@end
