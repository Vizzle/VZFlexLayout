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

@property (nonatomic, strong) VZFNodeHostingView *segmentedControl;
@property (nonatomic, strong) NSMutableDictionary *state;
@property (nonatomic, strong) UILabel *label;

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
                    [controller segmentedDidChanged];
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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _state = [[self initialState] mutableCopy];
    }
    return self;
}

- (NSDictionary *)initialState {
    return @{@"selectedSegmentedIndex":@(1), @"items": @[@"ALL", @"NEW ARRIVAL", @"ON SALE"]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"VZSegmentedControlNode";

    self.segmentedControl = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.segmentedControl.frame = CGRectMake(0, 64, self.view.frame.size.width, 50);
    [self.segmentedControl update:self.state context:self];
    [self.view addSubview:self.segmentedControl];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, 25)];
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:22.0f];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    [self updateHint];
}

- (void)segmentedDidChanged {
    [self updateHint];
}

- (void)updateHint {
    NSInteger selectedSegmentedIndex = [self.state[@"selectedSegmentedIndex"] integerValue];
    NSArray *items = self.state[@"items"];
    self.label.text = selectedSegmentedIndex < items.count ? items[selectedSegmentedIndex] : @"UNDEFINED";
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [SegmentedControlNode newWithProps:item Store:store Context:ctx];
}


@end
