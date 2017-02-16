//
//  VZFSegmentedControl.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/15.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFSegmentedControl.h"

@implementation VZFSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(didChange) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)setItems:(NSArray<NSString *> *)items {
    _items = [items copy];
    [self removeAllSegments];
    for (NSString *item in items) {
        [self insertSegmentWithTitle:item atIndex:self.numberOfSegments animated:NO];
    }
}

- (void)didChange {
    if (self.onChange) {
        NSDictionary *dict = @{@"selectedSegmentedIndex": @(self.selectedSegmentIndex)};
        self.onChange(dict);
    }
}

@end
