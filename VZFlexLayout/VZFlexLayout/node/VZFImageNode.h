//
//  VZFImageNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeSpecs.h"
#import "VZFImageNodeSpecs.h"

@interface VZFImageNode : VZFNode

@property(nonatomic,assign,readonly) ImageNodeSpecs imagesSpecs;
+ (instancetype)newWithNodeSpecs:(const NodeSpecs&)specs ImageAttributes:(const ImageNodeSpecs &)imageSpecs;


@end
