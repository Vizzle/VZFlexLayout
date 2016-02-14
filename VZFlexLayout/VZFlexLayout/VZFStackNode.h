//
//  VZFStackNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNode.h"
#import "VZFNodeUIAttributes.h"
#import <vector>

typedef NS_ENUM(NSUInteger, VZFStackLayoutDirection) {
   
    VZFStackLayoutDirectionHorizontal,
    VZFStackLayoutDirectionVertical,
};

typedef NS_ENUM(NSUInteger, VZFStackLayoutAlignItems) {
    VZFStackLayoutAlignItemsStart,
    VZFStackLayoutAlignItemsEnd,
    VZFStackLayoutAlignItemsCenter,
    VZFStackLayoutAlignItemsStretch
};

typedef NS_ENUM(NSUInteger, VZFStackLayoutJustifyContent) {
    VZFStackLayoutJustifyContentStart,
    VZFStackLayoutJustifyContentEnd,
    VZFStackLayoutJustifyContentCenter,
    VZFStackLayoutJustifyContentSpaceBetween
};

struct VZFStackChildNode{
    VZFNode *node;
};


struct VZFStackLayout{

    VZFStackLayoutDirection direction;
    VZFStackLayoutAlignItems alignItems;
    VZFStackLayoutJustifyContent justifyContent;
    VZ::FlexAttrs flex;
};

@interface VZFStackNode : VZFNode

@property(nonatomic,readonly) VZFStackLayout layout;
@property(nonatomic,readonly) std::vector<VZFStackChildNode> children;

+ (instancetype)nodeWithStackLayout:(const VZFStackLayout& )layout Children:(const std::vector<VZFStackChildNode> &)children;

@end
