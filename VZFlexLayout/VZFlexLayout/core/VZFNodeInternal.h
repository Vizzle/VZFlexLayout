//
//  VZFNodeInternal.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#ifndef VZFNodeInternal_h
#define VZFNodeInternal_h

#import "VZFNode.h"
#import "VZFNodeLayout.h"

typedef NS_OPTIONS(NSUInteger, NodeDescriptionOption) {
    NodeDescriptionOptionDefault = 0,
    NodeDescriptionOptionHideResult = 1 << 0,
    NodeDescriptionOptionHideUnspecified = 1 << 1,
    NodeDescriptionOptionHideChildren = 1 << 2,
};

@class VZFlexNode;
@interface VZFNode()

@property(nonatomic,strong,readonly)VZFlexNode* flexNode;

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz;

//for debugging
- (NSString *)propertiesDescription:(NodeDescriptionOption)option;
- (NSString *)recursiveDescription:(NodeDescriptionOption)option;

@end
#endif /* VZFNodeInternal_h */
