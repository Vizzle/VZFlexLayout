//
//  VZFMapAnnotation.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/21.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFMapAnnotation.h"

@implementation VZFMapAnnotation

+ (instancetype)newWithAnnotationSpecs:(const VZ::MapAnnotationSpecs &)annotationSpecs {
    VZFMapAnnotation *annotation = [VZFMapAnnotation new];
    annotation.coordinate = {
        .latitude = annotationSpecs.latitude,
        .longitude = annotationSpecs.longitude
    };
    annotation.title = annotationSpecs.title;
    annotation.subtitle = annotationSpecs.subTitle;
    if (annotationSpecs.identifier.length == 0) {
        annotation.identifier = [NSString stringWithFormat:@"latitude=%flongitude=%ftitle=%@", annotationSpecs.latitude, annotationSpecs.longitude, annotationSpecs.title];
    } else {
        annotation.identifier = annotationSpecs.identifier;
    }
    annotation.image = annotationSpecs.image;
    annotation.animateDrop = annotationSpecs.animateDrop;
    annotation.draggable = annotationSpecs.draggable;
    return annotation;
}

- (id)copyWithZone:(NSZone *)zone {
    VZFMapAnnotation *twin = [VZFMapAnnotation allocWithZone:zone];
    twin.identifier = self.identifier;
    twin.coordinate = self.coordinate;
    twin.title = self.title;
    twin.subtitle = self.subtitle;
    twin.image = self.image;
    twin.animateDrop = self.animateDrop;
    twin.draggable = self.draggable;
    return twin;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.identifier isEqual:((VZFMapAnnotation *)object).identifier];
}

- (NSUInteger)hash {
    return self.identifier.hash;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@, %p> { latitude: %f, longitude: %f, title: %@, subTitle:%@ }", NSStringFromClass(self.class), self,
            self.coordinate.latitude,
            self.coordinate.longitude,
            self.title,
            self.subtitle];
}

@end
