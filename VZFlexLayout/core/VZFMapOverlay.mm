//
//  VZFMapOverlay.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/22.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFMapOverlay.h"

@implementation VZFMapOverlay

+ (instancetype)newWithOverlaySpecs:(const VZ::MapOverlaySpecs &)specs {
    NSMutableString *identifier = [NSMutableString string];
    CLLocationCoordinate2D coordinates[specs.coordinates.size()];
    NSUInteger index = 0;
    for (auto item = specs.coordinates.begin(); item != specs.coordinates.end(); item++) {
        coordinates[index++] = *item;
        [identifier appendFormat:@"latitude=%flongitude=%f", (*item).latitude, (*item).longitude];
    }
    [identifier appendFormat:@"strokeColor=%@", specs.strokeColor];
    [identifier appendFormat:@"lineWidth=%f", specs.lineWidth];
    VZFMapOverlay *overlay = [VZFMapOverlay polylineWithCoordinates:coordinates
                                                              count:index];
    overlay.strokeColor = specs.strokeColor ?: [UIColor blackColor];
    overlay.lineWidth = fabs(specs.lineWidth) < FLT_EPSILON ? 1 : specs.lineWidth;
    overlay.identifier = specs.identifier ?: identifier;
    return overlay;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.identifier isEqual:((VZFMapOverlay *)object).identifier];
}

- (NSUInteger)hash {
    return self.identifier.hash;
}

@end
