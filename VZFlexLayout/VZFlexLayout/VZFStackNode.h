//
//  VZFStackNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeFlexAttributes.h"
#import <vector>

typedef NS_ENUM(NSUInteger, VZFStackLayoutDirection) {
    VZFStackLayoutDirectionVertical,
    VZFStackLayoutDirectionHorizontal,
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
    /** Additional space to place before the component in the stacking direction. */
    CGFloat spacingBefore;
    /** Additional space to place after the component in the stacking direction. */
    CGFloat spacingAfter;
    /** If the sum of childrens' stack dimensions is less than the minimum size, should this component grow? */
    BOOL flexGrow;
    /** If the sum of childrens' stack dimensions is greater than the maximum size, should this component shrink? */
    BOOL flexShrink;
};


struct VZFStackLayout{

    VZFStackLayoutDirection direction;
    VZFStackLayoutAlignItems alignItems;
    VZFStackLayoutJustifyContent justifyContent;
    VZFlexAttributes flexAttributes;
};

@interface VZFStackNode : VZFNode

+ (instancetype)nodeWithStackLayout:(const VZFStackLayout& )layout Children:(const std::vector<VZFStackChildNode> &)children;

@end
