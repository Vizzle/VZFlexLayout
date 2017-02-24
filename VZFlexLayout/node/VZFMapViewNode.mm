//
//  VZFMapViewNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFMapViewNode.h"
#import "VZFMapView.h"

@implementation VZFMapViewNode

+ (instancetype)newWithMapViewAttributes:(const VZ::MapViewNodeSpecs &)mapViewNodeSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs {
    VZFMapViewNode *node = [super newWithView:[VZFMapView class] NodeSpecs:nodeSpecs];
    if (node) {
        node -> _mapViewNodeSpecs = mapViewNodeSpecs.copy();
    }
    return node;
}

@end
