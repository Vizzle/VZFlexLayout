//
//  VZFPickerView.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFPickerView.h"
#import "UIView+VZAttributes.h"
#import "VZFPickerNode.h"

@interface VZFPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation VZFPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = NSNotFound;
        self.delegate = self;
    }
    return self;
}

- (void)setItems:(NSArray<NSString *> *)items {
    _items = [items copy];
    [self setNeedsLayout];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (selectedIndex >= 0 && selectedIndex < self.items.count) {
                [self selectRow:selectedIndex inComponent:0 animated:NO];
            }
        });
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.items.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.items[row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedIndex = row;
    if (self.onChange) {
        self.onChange(@{@"selectedIndex": @(row)});
    }
}

#pragma mark - Node spec attributes

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    PickerNodeSpecs specs = ((VZFPickerNode *)node).pickerSpecs;
    self.items = specs.items;
    self.selectedIndex = specs.selectedIndex.value;
    self.onChange = specs.onChange;
}

@end
