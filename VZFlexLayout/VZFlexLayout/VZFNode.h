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
#import <unordered_map>

typedef std::unordered_map<VZ::UIAttribute<UIView>, id> ViewAttributes;
typedef std::unordered_map<VZ::UIAttribute<CALayer>, id> LayerAttributes;
typedef VZ::FlexAttribute VZFlexAttributes;
typedef VZ::NodeLayout VZFNodeLayout;

@interface VZFNode : NSObject

+(instancetype)newWithClass:(Class)clz
            ViewAttributes:(const ViewAttributes &)view
             FlexAttributes:(const VZFlexAttributes &)flex;

+(instancetype)newWithClass:(Class)clz
             ViewAttributes:(const ViewAttributes &)view
            LayerAttributes:(const LayerAttributes &)layer
             FlexAttributes:(const VZFlexAttributes &)flex;

+ (id)initialState;

- (void)updateState:(id(^)(id))updateBlock;

- (VZFNodeLayout)layoutThatFits:(CGSize)sz;

@end
