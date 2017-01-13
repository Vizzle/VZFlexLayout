//
//  VZFTextFieldEventHandler.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/1/3.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFTextFieldEventHandler.h"

@interface VZFTextFieldEventHandler ()

@property (nonatomic, copy) void(^onEvent)(UITextField *textField, VZFTextFieldEventType type);

@end

@implementation VZFTextFieldEventHandler

- (instancetype)initWithHandler:(void (^)(UITextField *, VZFTextFieldEventType))block {
    self = [super init];
    if (self) {
        _onEvent = [block copy];
    }
    return self;
}

- (void)onEvent:(VZFTextFieldEventType)type sender:(UITextField *)textField {
    if (self.onEvent) {
        self.onEvent(textField, type);
    }
}

@end
