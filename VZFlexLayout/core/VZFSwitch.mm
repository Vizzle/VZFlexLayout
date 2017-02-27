//
//  VZFSwitch.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFSwitch.h"
#import "UIView+VZAttributes.h"
#import "VZFSwitchNode.h"

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

#pragma mark - Node spec attributes

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    SwitchNodeSpecs specs = ((VZFSwitchNode *)node).switchSpecs;
    self.on = specs.on;
    self.enabled = specs.enabled.value;
    if (specs.onTintColor) {
        self.onTintColor = specs.onTintColor;
    }
    if (specs.thumbTintColor) {
        self.thumbTintColor = specs.thumbTintColor;
    }
    self.onChange = specs.onChange;
}

@end
