//
//  FBHostNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"
#import "VZFNodeCreationAPI.h"
@class FBHostItem;
@interface FBHostNode : VZFCompositeNode

+ (instancetype)newWithProps:(id)props Store:(id)store Context:(id)context;

@end
