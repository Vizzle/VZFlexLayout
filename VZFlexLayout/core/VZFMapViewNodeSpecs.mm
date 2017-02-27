//
//  VZFMapViewNodeSpecs.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFMapViewNodeSpecs.h"

namespace VZ {
    namespace DefaultAttributesValue {
        MKCoordinateRegion undefinedRegion = {
            .center = {
                .latitude = -360,
                .longitude = -360
            },
            .span = {
                .latitudeDelta = 0,
                .longitudeDelta = 0,
            }
        };
    }
}
