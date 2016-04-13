//
//  VZFImageNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"

namespace VZ {
    class NodeSpecs;
    class ImageNodeSpecs;
}
using namespace VZ;

@interface VZFImageNode : VZFNode

@property(nonatomic,assign,readonly) ImageNodeSpecs imageSpecs;
+ (instancetype)newWithNodeSpecs:(const NodeSpecs&)specs ImageAttributes:(const ImageNodeSpecs &)imageSpecs;


@end
