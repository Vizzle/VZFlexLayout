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
#import "VZFMapAnnotation.h"
#import "VZFMapOverlay.h"

const CLLocationDegrees VZFMapDefaultSpanDelta = 0.005;

//@interface VZFMapAnnotationView : MKAnnotationView
//
//@property (nonatomic, strong) UIView *contentView;
//
//@end
//
//@implementation VZFMapAnnotationView
//
//- (void)setContentView:(UIView *)contentView {
//    [_contentView removeFromSuperview];
//    _contentView = contentView;
//    [self addSubview:_contentView];
//}
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.bounds = (CGRect){
//        CGPointZero,
//        _contentView.frame.size,
//    };
//}
//
//@end

@interface VZFMapView () <MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

- (void)setAnnotations:(NSArray<VZFMapAnnotation *> *)annotations;
- (void)setOverlays:(NSArray<VZFMapOverlay *> *)overlays;

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

- (void)setAnnotations:(NSArray<VZFMapAnnotation *> *)annotations {
    NSMutableArray<VZFMapAnnotation *> *annotationsToDelete = [NSMutableArray array];
    NSMutableArray<VZFMapAnnotation *> *annotationsToAdd = [NSMutableArray array];
    
    for (VZFMapAnnotation *annotation in annotations) {
        if (![annotation isKindOfClass:[VZFMapAnnotation class]]) {
            continue;
        }
        
        if (![self.annotations containsObject:annotation]) {
            [annotationsToAdd addObject:annotation];
        }
    }
    
    for (VZFMapAnnotation *annotation in self.annotations) {
        if (![annotation isKindOfClass:[VZFMapAnnotation class]]) {
            continue;
        }
        
        if (![annotations containsObject:annotation]) {
            [annotationsToDelete addObject:annotation];
        }
    }
    
    if (annotationsToDelete.count > 0) {
        [self removeAnnotations:annotationsToDelete];
    }
    
    if (annotationsToAdd.count > 0) {
        [self addAnnotations:annotationsToAdd];
    }
}

- (void)setOverlays:(NSArray<VZFMapOverlay *> *)overlays {
    NSMutableArray<VZFMapOverlay *> *overlayToDelete = [NSMutableArray array];
    NSMutableArray<VZFMapOverlay *> *overlayToAdd = [NSMutableArray array];
    
    for (VZFMapOverlay *overlay in overlays) {
        if (![overlay isKindOfClass:[VZFMapOverlay class]]) {
            continue;
        }
        if (![self.overlays containsObject:overlay]) {
            [overlayToAdd addObject:overlay];
        }
    }
    
    for (VZFMapOverlay *overlay in self.overlays) {
        if (![overlay isKindOfClass:[VZFMapOverlay class]]) {
            continue;
        }
        if (![overlays containsObject:overlay]) {
            [overlayToDelete addObject:overlay];
        }
    }
    
    if (overlayToDelete.count > 0) {
        [self removeOverlays:overlayToDelete];
    }
    
    if (overlayToAdd.count > 0) {
        [self addOverlays:overlayToAdd level:MKOverlayLevelAboveRoads];
    }
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(VZFMapAnnotation *)annotation {
    if (![annotation isKindOfClass:[VZFMapAnnotation class]]) {
        return nil;
    }
    
    MKAnnotationView *annotationView;
    if (annotation.image) {
        NSString *reuseIdentifier = NSStringFromClass([MKAnnotationView class]);
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier] ?:
        [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        annotationView.image = annotation.image;
    } else {
        NSString *reuseIdentifier = NSStringFromClass([MKPinAnnotationView class]);
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier] ?:
        [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        ((MKPinAnnotationView *)annotationView).animatesDrop = annotation.animateDrop;        
    }
    annotationView.canShowCallout = annotation.title.length > 0;
    annotationView.draggable = annotation.draggable;
    return annotationView;
}

- (void)mapView:(VZFMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    if (mapView.showsAnnotationCallouts) {
        for (id<MKAnnotation> annotation in mapView.annotations) {
            [mapView selectAnnotation:annotation animated:YES];
        }
    }
}

- (void)mapView:(VZFMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[VZFMapAnnotation class]]) {
        VZFMapAnnotation *annotation = (VZFMapAnnotation *)view.annotation;
        if (mapView.onAnnotationPress) {
            mapView.onAnnotationPress(@{
                              @"annotation": [annotation copy]
                              });
        }
        
        if (mapView.onAnnotationFocus) {
            mapView.onAnnotationFocus(@{@"annotation": [annotation copy]});
        }
    }
}

- (void)mapView:(VZFMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[VZFMapAnnotation class]]) {
        VZFMapAnnotation *annotation = (VZFMapAnnotation *)view.annotation;
        if (mapView.onAnnotationBlur) {
            mapView.onAnnotationBlur(@{@"annotation": [annotation copy]});
        }
    }
}

- (void)mapView:(VZFMapView *)mapView
 annotationView:(MKAnnotationView *)view
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    static NSArray *states;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        states = @[@"idle", @"starting", @"dragging", @"canceling", @"ending"];
    });
    
    if ([view.annotation isKindOfClass:[VZFMapAnnotation class]]) {
        VZFMapAnnotation *annotation = (VZFMapAnnotation *)view.annotation;
        if (mapView.onAnnotationDragStateChange) {
            mapView.onAnnotationDragStateChange(@{
                                                  @"state": states[newState],
                                                  @"oldState": states[oldState],
                                                  @"annotation": [annotation copy],
                                                  });
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(VZFMapOverlay *)overlay {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = overlay.strokeColor;
    renderer.lineWidth = overlay.lineWidth;
    return renderer;
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
    self.onAnnotationPress = specs.onAnnotationPress;
    self.onAnnotationFocus = specs.onAnnotationFocus;
    self.onAnnotationBlur = specs.onAnnotationBlur;
    self.onAnnotationDragStateChange = specs.onAnnotationDragStateChange;
    NSMutableArray<VZFMapAnnotation *> *annotations = [NSMutableArray array];
    for(auto item = specs.annotations.begin(); item != specs.annotations.end(); item++){
        VZFMapAnnotation *annotation = [VZFMapAnnotation newWithAnnotationSpecs:*item];
        [annotations addObject:annotation];
    }
    [self setAnnotations:annotations];
    NSMutableArray<VZFMapOverlay *> *overlays = [NSMutableArray array];
    for (auto item = specs.overlays.begin(); item != specs.overlays.end(); item++) {
        VZFMapOverlay *overlay = [VZFMapOverlay newWithOverlaySpecs:*item];
        [overlays addObject:overlay];
    }
    [self setOverlays:overlays];
}

@end
