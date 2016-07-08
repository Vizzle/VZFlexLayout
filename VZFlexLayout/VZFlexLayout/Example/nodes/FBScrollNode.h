//
//  FBScrollNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/5/8.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"
#import "VZFNodeCreationAPI.h"

@class FBHostItem;
@interface FBScrollNode : VZFCompositeNode<VZFNodeCreationAPI>

+ (instancetype)newWithProps:(id)props Store:(id)store Context:(id)context;


@end
