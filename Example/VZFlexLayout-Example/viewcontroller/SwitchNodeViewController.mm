//
//  SwitchNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "SwitchNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface SwitchNodeViewController () <VZFNodeProvider, VZFNodeHostingView>

- (void)switchDidChange;

@end

@interface SwitchNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation SwitchNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    BOOL on = [props[@"switchOn"] boolValue];
    
    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexHorizontal,
        .alignItems = VZFlexCenter,
        .justifyContent = VZFlexCenter,
    } NodeSpecs:{
    } Children:{
        {
            [VZFSwitchNode newWithSwitchAttributes:{
                .on = on,
                .onTintColor = [UIColor redColor],
                .thumbTintColor = [UIColor greenColor],
                .onChange = ^(NSDictionary *body) {
                    __weak SwitchNodeViewController *controller = ctx;
                    controller.state[@"switchOn"] = body[@"on"];
                    [controller switchDidChange];
                }
            } NodeSpecs:{
            }]
        }
    }];
    return [super newWithNode:node];
}

@end

@implementation SwitchNodeViewController

- (NSDictionary *)initialState {
    return @{@"switchOn": @YES};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"VZSwitchNode";
    
    self.hostingView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.hostingView.frame = CGRectMake(0, 64, self.view.frame.size.width, 60);
    self.hostingView.delegate = self;
    [self.hostingView update:self.state context:self];
    [self.view addSubview:self.hostingView];
    
    [self update];
}

- (void)switchDidChange {
    [self update];
}

- (void)update {
    BOOL on = [self.state[@"switchOn"] boolValue];
    self.infoLabel.text = on ? @"ON" : @"OFF";
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [SwitchNode newWithProps:item Store:store Context:ctx];
}

@end
