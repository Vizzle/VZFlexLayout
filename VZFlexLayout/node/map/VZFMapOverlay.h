//
//  VZFMapOverlay.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VZFMapViewNodeSpecs.h"

@interface VZFMapOverlay : MKPolyline

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat lineWidth;

+ (instancetype)newWithOverlaySpecs:(const MapOverlaySpecs &)specs;

@end
