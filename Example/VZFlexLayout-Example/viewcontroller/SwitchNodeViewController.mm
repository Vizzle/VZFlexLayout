//
//  SwitchNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "SwitchNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface SwitchNodeViewController ()

@property (nonatomic, strong) VZFNodeHostingView *switcher;
@property (nonatomic, copy) NSMutableDictionary *state;

- (void)update;

@end

@interface SwitchNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation SwitchNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    BOOL on = [props[@"switchOn"] boolValue];
    
    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
        .direction = VZFlexHorizontal,
        .alignItems = VZFlexStretch,
    } NodeSpecs:{
        .padding = 5,
    } Children:{
        {
            [VZFSwitchNode newWithSwitchAttributes:{
                .on = on,
                .action = [VZFBlockAction actionWithControlEvents:UIControlEventValueChanged block:^(id sender) {
                    NSLog(@"Switcher value changed: {%ld}", (long)((UISwitch *)sender).on);
                    __weak SwitchNodeViewController *controller = ctx;
                    controller.state[@"switchOn"] = @(((UISwitch *)sender).on);
                    [controller update];
                }]
            } NodeSpecs:{
                .width = 60,
                .height = 26,
            }]
        },
        {
            [VZFTextNode newWithTextAttributes:{
                .text = on ? @"ON" : @"OFF",
                .fontSize = 20,
            } NodeSpecs:{
                
            }]
        }
    }];
    return [super newWithNode:node];
}

@end

@implementation SwitchNodeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _state = [[self initialState] mutableCopy];
    }
    return self;
}

- (NSDictionary *)initialState {
    return @{@"switchOn": @YES};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"VZSwitchNode";
    
    self.switcher = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeWidthAndHeight];
    self.switcher.frame = CGRectMake(0, 64, 0, 0);
    [self.switcher update:self.state context:self];
    [self.view addSubview:self.switcher];
}

- (void)update {
    [self.switcher update:self.state context:self];
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [SwitchNode newWithProps:item Store:store Context:ctx];
}

@end
