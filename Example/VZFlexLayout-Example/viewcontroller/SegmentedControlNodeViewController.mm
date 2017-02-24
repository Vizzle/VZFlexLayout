//
//  SegmentedControlNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "SegmentedControlNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface SegmentedControlNodeViewController () <VZFNodeProvider>

- (void)segmentedDidChanged;

@end

@interface SegmentedControlNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation SegmentedControlNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    NSInteger selectedSegmentedIndex = [props[@"selectedSegmentedIndex"] integerValue];
    NSArray *items = props[@"items"];
    VZFStackNode *stack = [VZFStackNode newWithStackAttributes:{
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        {
            [VZFSegmentedControlNode newWithSegmentedControlAttributes:{
                .items = [items copy],
                .selectedSegmentedIndex = selectedSegmentedIndex,
                .onChange = ^(NSDictionary *body) {
                    __weak SegmentedControlNodeViewController *controller = ctx;
                    controller.state[@"selectedSegmentedIndex"] = body[@"selectedSegmentedIndex"];
                    [controller update];
                }
            } NodeSpecs:{
                .flexGrow = 1,
            }]
        }
    }];
    
    return [super newWithNode:stack];
}

@end

@implementation SegmentedControlNodeViewController

- (NSDictionary *)initialState {
    return @{@"selectedSegmentedIndex":@(1), @"items": @[@"ALL", @"NEW ARRIVAL", @"ON SALE"]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"VZSegmentedControlNode";

    self.hostingView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.hostingView.frame = CGRectMake(0, 64, self.view.frame.size.width, 50);
    [self.hostingView update:self.state context:self];
    [self.view addSubview:self.hostingView];
    
    [self update];
}

- (void)segmentedDidChanged {
    [self update];
}

- (void)update {
    NSInteger selectedSegmentedIndex = [self.state[@"selectedSegmentedIndex"] integerValue];
    NSArray *items = self.state[@"items"];
    self.infoLabel.text = selectedSegmentedIndex < items.count ? items[selectedSegmentedIndex] : @"UNDEFINED";
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [SegmentedControlNode newWithProps:item Store:store Context:ctx];
}


@end
