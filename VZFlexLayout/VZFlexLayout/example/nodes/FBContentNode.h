//
//  FBHeadNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"
#import "VZFNodeCreationAPI.h"

@class FBHostItem;
@interface FBContentNode : VZFCompositeNode<VZFNodeCreationAPI>

+ (instancetype)newWithProps:(id)props Store:(id)store Context:(id)context;


@end

