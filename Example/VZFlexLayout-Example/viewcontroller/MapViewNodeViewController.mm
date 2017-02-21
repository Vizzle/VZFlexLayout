//
//  MapViewNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/21.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "MapViewNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>
#import <MapKit/MapKit.h>

@interface MapNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation MapNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    
    CGFloat mapHeight = 200;
    
    VZFScrollNode *node = [VZFScrollNode newWithScrollAttributes:{
        .scrollDirection = VZ::ScrollDirection::ScrollVertical
    } StackAttributes:{
        .direction = VZFlexVertical,
        .alignItems = VZFlexStretch,
        .spacing = 10,
    } NodeSpecs:{
        .padding = 20,
    } Children:{
        [VZFMapViewNode newWithMapViewAttributes:{
            .showsUserLocation = YES,
            .followUserLocation = YES,
        }NodeSpecs:{
            .height = mapHeight,
        }],
        [VZFMapViewNode newWithMapViewAttributes:{
            .region = (MKCoordinateRegion){
                .center = {
                    .latitude = 30.2795924,
                    .longitude = 120.0228532
                },
                .span = {
                    .latitudeDelta = 0.005,
                    .longitudeDelta = 0.005,
                }
            },
            .annotations = {
                {
                    .latitude = 30.2795924,
                    .longitude = 120.0228532,
                    .title = @"Alibaba",
                    .subTitle = @"Xixi Park"
                }
            },
            .onAnnotationPress = ^(NSDictionary *body) {
                NSLog(@"Annotation pressed: %@", body);
            },
            .onAnnotationFocus = ^(NSDictionary *body) {
                NSLog(@"Annotation foucused: %@", body);
            },
            .onAnnotationBlur = ^(NSDictionary *body) {
                NSLog(@"Annotation blured: %@", body);
            }
        }NodeSpecs:{
            .height = mapHeight,
        }],
        [VZFMapViewNode newWithMapViewAttributes:{
            .region = (MKCoordinateRegion){
                .center = {
                    .latitude = 30.2726853,
                    .longitude = 120.124668
                },
                .span = {
                    .latitudeDelta = 0.005,
                    .longitudeDelta = 0.005,
                }
            },
            .annotations = {
                {
                    .latitude = 30.2726853,
                    .longitude = 120.124668,
                    .title = @"Zhifubao",
                    .subTitle = @"Wantang Road",
                    .image = [UIImage imageNamed:@"icon_annotation"],
                    .animateDrop = YES,
                    .draggable = YES,
                }
            }
        }NodeSpecs:{
            .height = mapHeight,
        }]
    }];
    
    return [super newWithNode:node];
}

@end

@interface MapViewNodeViewController () <VZFNodeProvider>

@end

@implementation MapViewNodeViewController

- (NSDictionary *)initialState {
    return [@{} mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"VZFMapViewNode";
    
    self.hostingView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.hostingView.frame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(64, 0, 0, 0));
    [self.hostingView update:self.state context:self];
    [self.view addSubview:self.hostingView];
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [MapNode newWithProps:item Store:store Context:ctx];
}


@end
