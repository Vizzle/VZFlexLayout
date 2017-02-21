//
//  VZFMapViewNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "VZFValue.h"
#import "VZFNodeSpecs.h"

namespace VZ {
    
    namespace DefaultAttributesValue {
        extern MKCoordinateRegion undefinedRegion;
    }
    
    struct MapViewNodeSpecs {
        MKMapType mapType;
        BOOL showsUserLocation;
        BOOL followUserLocation;
        BOOL showsAnnotationCallouts;
        Value<BOOL, DefaultControlAttrValue::able> zoomEnabled;
        Value<BOOL, DefaultControlAttrValue::able> scrollEnabled;
        Value<BOOL, DefaultControlAttrValue::able> rotateEnabled;
        Value<BOOL, DefaultControlAttrValue::able> pitchEnabled;
        Value<MKCoordinateRegion, DefaultAttributesValue::undefinedRegion> region;
        
        MapViewNodeSpecs copy() const {
            return {
                mapType,
                showsUserLocation,
                followUserLocation,
                showsAnnotationCallouts,
                zoomEnabled,
                scrollEnabled,
                rotateEnabled,
                pitchEnabled,
                region,
            };
        }
    };
}
