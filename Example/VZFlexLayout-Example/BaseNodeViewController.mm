//
//  BaseNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "BaseNodeViewController.h"

@interface BaseNodeViewController ()

@end


@implementation BaseNodeViewController

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
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.textColor = [UIColor redColor];
    self.infoLabel.font = [UIFont systemFontOfSize:22.0f];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.infoLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.infoLabel.frame = CGRectMake(0,
                                      self.hostingView.frame.origin.y + self.hostingView.frame.size.height,
                                      self.view.frame.size.width,
                                      30);
}

- (NSDictionary *)initialState {
    return @{};
}

- (void)update {
    
}

@end
