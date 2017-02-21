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
    
    struct MapAnnotationSpecs {
        NSString *identifier;
        CLLocationDegrees latitude;
        CLLocationDegrees longitude;
        NSString *title;
        NSString *subTitle;
        UIImage *image;
        BOOL animateDrop;
        BOOL draggable;
    };
    
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
        std::vector<MapAnnotationSpecs> annotations;
        VZFEventBlock onAnnotationPress;
        VZFEventBlock onAnnotationFocus;
        VZFEventBlock onAnnotationBlur;
        
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
                annotations,
                [onAnnotationPress copy],
                [onAnnotationFocus copy],
                [onAnnotationBlur copy]
            };
        }
    };
}
