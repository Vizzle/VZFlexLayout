//
//  VZFSwitch.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFSwitch.h"

@implementation VZFSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(didChange) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)didChange {
    if (self.onChange) {
        self.onChange(@{@"on": @(self.on)});
    }
}

@end