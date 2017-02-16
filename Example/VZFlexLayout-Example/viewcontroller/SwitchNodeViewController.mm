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

@property (nonatomic, strong) VZFNodeHostingView *switcher;
@property (nonatomic, copy) NSMutableDictionary *state;
@property (nonatomic, strong) UILabel *label;

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
    
    self.switcher = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.switcher.frame = CGRectMake(0, 64, self.view.frame.size.width, 60);
    self.switcher.delegate = self;
    [self.switcher update:self.state context:self];
    [self.view addSubview:self.switcher];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                           self.switcher.frame.origin.y + self.switcher.frame.size.height,
                                                           self.view.frame.size.width,
                                                           25)];
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:22.0f];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    [self updateHint];
}

- (void)switchDidChange {
    [self updateHint];
}

- (void)updateHint {
    BOOL on = [self.state[@"switchOn"] boolValue];
    self.label.text = on ? @"ON" : @"OFF";
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [SwitchNode newWithProps:item Store:store Context:ctx];
}

@end
