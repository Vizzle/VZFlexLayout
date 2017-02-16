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

@property (nonatomic, strong) VZFNodeHostingView *pickerView;
@property (nonatomic, copy) NSMutableDictionary *state;
@property (nonatomic, strong) UILabel *label;


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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _state = [[self initialState] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"VZPickerNode";
    
    self.pickerView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.pickerView.frame = CGRectMake(0, 64, self.view.frame.size.width, 120);
    [self.pickerView update:self.state context:self];
    [self.view addSubview:self.pickerView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 184, self.view.frame.size.width, 25)];
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:22.0f];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    [self updateHint];
}

- (NSDictionary *)initialState {
    return @{@"selectedIndex":@(1), @"items": @[@"Mist", @"React", @"O2O"]};
}

- (void)pickerDidChange {
    [self updateHint];
}

- (void)updateHint {
    NSArray *items = self.state[@"items"];
    NSInteger selectedIndex = [self.state[@"selectedIndex"] integerValue];
    self.label.text = selectedIndex < items.count ? items[selectedIndex] : @"UNDEFINED";
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [PickerNode newWithProps:item Store:store Context:ctx];
}

@end
