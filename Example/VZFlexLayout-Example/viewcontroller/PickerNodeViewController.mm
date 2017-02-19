//
//  PickerNodeViewController.mm
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "PickerNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface PickerNodeViewController () <VZFNodeProvider>


- (void)pickerDidChange;

@end

@interface PickerNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation PickerNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    NSArray *items = props[@"items"];
    NSInteger selectedIndex = [props[@"selectedIndex"] integerValue];
    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexVertical,
    } NodeSpecs:{
        .padding = 15,
    } Children:{
        {
            [VZFPickerNode newWithPickerAttributes:{
                .selectedIndex = selectedIndex,
                .items = [items copy],
                .onChange = ^(NSDictionary *body) {
                    __weak PickerNodeViewController *controller = ctx;
                    controller.state[@"selectedIndex"] = body[@"selectedIndex"];
                    [controller pickerDidChange];
                }
            } NodeSpecs:{
                .flexGrow = 1,
            }]
        }
    }];
    
    return [super newWithNode:node];
}

@end

@implementation PickerNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"VZPickerNode";
    
    self.hostingView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.hostingView.frame = CGRectMake(0, 64, self.view.frame.size.width, 120);
    [self.hostingView update:self.state context:self];
    [self.view addSubview:self.hostingView];
    
    [self update];
}

- (NSDictionary *)initialState {
    return @{@"selectedIndex":@(1), @"items": @[@"Mist", @"React", @"O2O"]};
}

- (void)pickerDidChange {
    [self update];
}

- (void)update {
    NSArray *items = self.state[@"items"];
    NSInteger selectedIndex = [self.state[@"selectedIndex"] integerValue];
    self.infoLabel.text = selectedIndex < items.count ? items[selectedIndex] : @"UNDEFINED";
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [PickerNode newWithProps:item Store:store Context:ctx];
}

@end
