//
//  VZFMapViewNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFMapViewNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class MapViewNodeSpecs;
}

using namespace VZ;

@interface VZFMapViewNode : VZFNode

@property (nonatomic, assign, readonly) MapViewNodeSpecs mapViewNodeSpecs;

+ (instancetype)newWithMapViewAttributes:(const MapViewNodeSpecs &)mapViewNodeSpecs
                               NodeSpecs:(const NodeSpecs &)nodeSpecs;

@end
