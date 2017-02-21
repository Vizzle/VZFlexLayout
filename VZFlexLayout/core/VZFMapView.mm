//
//  VZFMapView.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFMapView.h"
#import "UIView+VZAttributes.h"
#import "VZFMapViewNode.h"

const CLLocationDegrees VZFMapDefaultSpanDelta = 0.005;

@interface VZFMapView () <MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation VZFMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)setShowsUserLocation:(BOOL)showsUserLocation {
    if (self.showsUserLocation == showsUserLocation) {
        return;
    }
    
    [self requestUserLocation];
    super.showsUserLocation = showsUserLocation;
}

- (void)requestUserLocation {
    if (!self.locationManager) {
        self.locationManager = [CLLocationManager new];
    }
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)setRegion:(MKCoordinateRegion)region animated:(BOOL)animated {
    if (!CLLocationCoordinate2DIsValid(region.center)) {
        return;
    }
    
    if (!region.span.latitudeDelta) {
        region.span.latitudeDelta = self.region.span.latitudeDelta;
    }
    
    if (!region.span.longitudeDelta) {
        region.span.longitudeDelta = self.region.span.longitudeDelta;
    }
    
    [super setRegion:region animated:animated];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (self.followUserLocation) {
        MKCoordinateRegion region;
        region.span.latitudeDelta = VZFMapDefaultSpanDelta;
        region.span.longitudeDelta = VZFMapDefaultSpanDelta;
        region.center = userLocation.coordinate;
        [mapView setRegion:region animated:YES];
    }
}

#pragma mark - Node spec attributes

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    MapViewNodeSpecs specs = ((VZFMapViewNode *)node).mapViewNodeSpecs;
    self.mapType = specs.mapType;
    self.followUserLocation = specs.followUserLocation;
    self.showsUserLocation = specs.showsUserLocation;
    self.showsAnnotationCallouts = specs.showsAnnotationCallouts;
    self.zoomEnabled = specs.zoomEnabled.value;
    self.scrollEnabled = specs.scrollEnabled.value;
    self.rotateEnabled = specs.rotateEnabled.value;
    self.pitchEnabled = specs.pitchEnabled.value;
    self.region = specs.region;
}

@end
