//
//  VZFMapView.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "VZFEvent.h"

@interface VZFMapView : MKMapView

@property (nonatomic, assign) BOOL followUserLocation;
@property (nonatomic, assign) BOOL showsAnnotationCallouts;
@property (nonatomic, copy) VZFEventBlock onAnnotationPress;
@property (nonatomic, copy) VZFEventBlock onAnnotationFocus;
@property (nonatomic, copy) VZFEventBlock onAnnotationBlur;
@property (nonatomic, copy) VZFEventBlock onAnnotationDragStateChange;

@end
