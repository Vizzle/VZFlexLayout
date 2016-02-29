//
//  FBHostNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"

@class FBHostItem;
@interface FBHostNode : VZFCompositeNode

+ (instancetype)newWithItem:(FBHostItem* )item;

@end
