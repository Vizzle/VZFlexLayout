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
//    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
//        .direction = VZFlexVertical,
//        .alignItems = VZFlexStretch,
//    } NodeSpecs:{
//        .padding = 10,
//    } Children:{
//        {
//            [VZFMapViewNode newWithMapViewAttributes:{
//                .showsUserLocation = YES,
//                .followUserLocation = YES,
//            }NodeSpecs:{
//                .height = 150,
//            }]
//        }
//    }];
    
    VZFScrollNode *node = [VZFScrollNode newWithScrollAttributes:{
        .scrollDirection = VZ::ScrollDirection::ScrollVertical
    } StackAttributes:{
        .direction = VZFlexVertical,
        .alignItems = VZFlexStretch,
        .spacing = 10,
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        [VZFMapViewNode newWithMapViewAttributes:{
            .showsUserLocation = YES,
            .followUserLocation = YES,
        }NodeSpecs:{
            .height = 150,
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
        }NodeSpecs:{
            .height = 150,
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
