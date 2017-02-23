//
//  VZFTextView.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFTextView.h"
#import "UIView+VZAttributes.h"
#import "VZFTextViewNode.h"
#import "VZFlexNode.h"
#import "VZFNodeInternal.h"

@interface VZFTextView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation VZFTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxLength = NSUIntegerMax;
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        [self addSubview:_textView];
    }
    return self;
}

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    TextViewNodeSpecs specs = ((VZFTextViewNode *)node).textViewNodeSpecs;
    self.textView.text = specs.text;
    self.textView.font = specs.font;
    self.textView.textColor = specs.color;
    self.textView.textAlignment = specs.alignment;
    self.placeholder = specs.placeholder;
    self.textView.editable = specs.editable.value;
    self.textView.secureTextEntry = specs.secureTextEntry;
    self.textView.keyboardType = specs.keyboardType;
    self.textView.keyboardAppearance = specs.keyboardAppearance;
    self.textView.returnKeyType = specs.returnKeyType;
    self.maxLength = specs.maxLength.value;
    self.textView.textContainerInset = node.flexNode.resultPadding;
    self.onFocus = specs.onFocus;
    self.onBlur = specs.onBlur;
    self.onChange = specs.onChange;
    self.onSubmit = specs.onSubmit;
    self.onKeyPress = specs.onKeyPress;
    self.onEnd = specs.onEnd;

}

@end
