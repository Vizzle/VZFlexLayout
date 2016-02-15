//
//  VZFStackNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNode.h"
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


struct VZFStackLayoutSpecs{

    VZFStackLayoutDirection direction;
    VZFStackLayoutAlignItems alignItems;
    VZFStackLayoutJustifyContent justifyContent;
    
    //VZStackLayoutSpecs stackSpecs;
    VZUISpecs viewSpecs;
};

@interface VZFStackNode : VZFNode

@property(nonatomic,assign,readonly) std::vector<VZFStackChildNode> children;

+ (instancetype)nodeWithStackSpecs:(const VZUISpecs& )specs Children:(const std::vector<VZFStackChildNode> &)children;


@end
