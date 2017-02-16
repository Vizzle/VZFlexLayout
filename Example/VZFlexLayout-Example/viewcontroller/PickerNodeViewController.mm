//
//  PickerNodeViewController.mm
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "PickerNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface PickerNodeViewController ()

@property (nonatomic, strong) VZFNodeHostingView *pickerView;
@property (nonatomic, copy) NSMutableDictionary *state;

- (void)update;

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
                    [controller update];
                }
            } NodeSpecs:{
                .width = 200,
                .height = 100,
            }]
        },
        {
            [VZFTextNode newWithTextAttributes:{
                .fontSize = 20,
                .color = [UIColor whiteColor],
                .alignment = NSTextAlignmentCenter,
                .text = (selectedIndex >= 0 && selectedIndex < items.count) ? items[selectedIndex] : @"NULL"
            } NodeSpecs:{
                .backgroundColor = [UIColor redColor],
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
    
    self.pickerView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeWidthAndHeight];
    self.pickerView.frame = CGRectMake(0, 64, 0, 0);
    [self.pickerView update:self.state context:self];
    [self.view addSubview:self.pickerView];
}

- (NSDictionary *)initialState {
    return @{@"selectedIndex":@(1), @"items": @[@"Mist", @"React", @"O2O"]};
}

- (void)update {
    [self.pickerView update:self.state context:self];
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [PickerNode newWithProps:item Store:store Context:ctx];
}

@end
