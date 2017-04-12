//
//  VZFTextViewNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFTextViewNode.h"
#import "VZFTextView.h"

@implementation VZFTextViewNode

+ (instancetype)newWithTextViewAttributes:(const VZ::TextViewNodeSpecs &)textViewNodeSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs {
    VZFTextViewNode *node = [super newWithView:[VZFTextView class] NodeSpecs:nodeSpecs];
    if (node) {
        node -> _textViewNodeSpecs = textViewNodeSpecs.copy();
    }
    return node;
}

@end
