//
//  FBHeadNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"

@class FBHostItem;
@interface FBContentNode : VZFCompositeNode

@property (nonatomic, readonly) BOOL expanded;

+ (instancetype)newWithItem:(FBHostItem* )item;

@end

