//
//  VZFTextFieldNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextFieldNode.h"
#import "VZFTextField.h"

@implementation VZFTextFieldNode
@synthesize textFieldSpecs = _textFieldSpecs;

+ (instancetype)newWithTextFieldAttributes:(const VZ::TextFieldNodeSpecs &)textFieldSpecs NodeSpecs:(const VZ::NodeSpecs &)specs {
    ViewClass viewClass = ViewClass(^(CGRect frame) {
        VZFTextField *textFeild = [[VZFTextField alloc] init];
        return textFeild;
    }, @"VZFTextField");
    VZFTextFieldNode *node = [super newWithView:viewClass NodeSpecs:specs];
    if (node) {
        node->_textFieldSpecs = textFieldSpecs.copy();
    }
    return node;
}

@end
