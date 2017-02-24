//
//  VZFMapAnnotation.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/21.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VZFMapViewNodeSpecs.h"

namespace VZ {
    class MapAnnotationSpecs;
}

using namespace VZ;

@interface VZFMapAnnotation : MKPointAnnotation <MKAnnotation, NSCopying>

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) BOOL hasLeftCallout;
@property (nonatomic, assign) BOOL hasRightCallout;
@property (nonatomic, assign) BOOL animateDrop;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL draggable;

+ (instancetype)newWithAnnotationSpecs:(const MapAnnotationSpecs &)annotationSpecs;

@end
