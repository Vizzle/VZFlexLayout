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

@class VZFUITextView;
@protocol VZFUITextViewDelegate <NSObject>

@optional
- (void)didResignFirstResponder:(VZFUITextView *)textView;

@end

@interface VZFUITextView : UITextView

@property (nonatomic, assign) BOOL textWasPasted;
@property (nonatomic, weak) id<VZFUITextViewDelegate> otherDelegate;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation VZFUITextView

- (void)paste:(id)sender {
    self.textWasPasted = YES;
    [super paste:sender];
}

- (BOOL)resignFirstResponder {
    BOOL ret = [super resignFirstResponder];
    if (ret) {
        [self.window removeGestureRecognizer:self.tapGesture];
        if ([self.otherDelegate respondsToSelector:@selector(didResignFirstResponder:)]) {
            [self.otherDelegate didResignFirstResponder:self];
        }
    }
    return ret;
}

- (BOOL)becomeFirstResponder {
    BOOL ret = [super becomeFirstResponder];
    if (ret) {
        [self.window addGestureRecognizer:self.tapGesture];
    }
    return ret;
}

#pragma mark - Gesture

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    }
    return _tapGesture;
}

- (void)backgroundTapped:(UITapGestureRecognizer *)tap {
    [self resignFirstResponder];
}

@end

@interface VZFTextView () <UITextViewDelegate, VZFUITextViewDelegate>

@property (nonatomic, strong) VZFUITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation VZFTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxLength = NSUIntegerMax;
        _textView = [[VZFUITextView alloc] initWithFrame:self.bounds];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.otherDelegate = self;
        [self addSubview:_textView];
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        [self addSubview:_placeholderLabel];
    }
    return self;
}

- (void)updatePlaceholder {
    self.placeholderLabel.hidden = NO;
    self.placeholderLabel.font = self.textView.font;
    self.placeholderLabel.textColor = self.placeholderColor;
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.hidden = self.textView.text.length > 0 || self.placeholder.length == 0;
}

- (void)layoutPlaceholder {
    CGFloat left = self.textView.textContainerInset.left + 5;
    CGFloat right = self.textView.textContainerInset.right + 5;
    CGFloat width = self.frame.size.width - (left + right);
    CGFloat top = self.textView.textContainerInset.top;
    self.placeholderLabel.frame = CGRectMake(left, top, width, 0);
    [self.placeholderLabel sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutPlaceholder];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window && self.autoFocus) {
        [self.textView becomeFirstResponder];
    }
}

- (NSMutableDictionary *)baseEvent {
    return [@{@"sender": self.textView} mutableCopy];
}

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    BOOL result = [self.textView resignFirstResponder];
    if (result) {
        if (self.onBlur) {
            self.onBlur([self baseEvent]);
        }
    }
    return result;
}

- (void)didResignFirstResponder:(VZFUITextView *)textView {
    if (self.onBlur) {
        self.onBlur([self baseEvent]);
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = (textView.text.length > 0);
    if (self.onChange) {
        self.onChange([self baseEvent]);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.onFocus) {
        self.onFocus([self baseEvent]);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.onEnd) {
        self.onEnd([self baseEvent]);
    }
}

- (BOOL)textView:(VZFUITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.textWasPasted) {
        textView.textWasPasted = NO;
    } else {
        if (self.blurOnSubmit && [text isEqualToString:@"\n"]) {
            if (self.onSubmit) {
                self.onSubmit([self baseEvent]);
            }
            [self resignFirstResponder];
            return NO;
        }
    }
    if (self.maxLength == NSUIntegerMax) {
        return YES;
    }
    
    NSUInteger allowedLength = self.maxLength - MIN(self.maxLength, self.textView.text.length) + range.length;
    if (text.length > allowedLength) {
        if (text.length > 1) {
            NSString *limitedString = [text substringToIndex:allowedLength];
            NSMutableString *newString = textView.text.mutableCopy;
            [newString replaceCharactersInRange:range withString:limitedString];
            textView.text = newString;
            [self textViewDidChange:textView];
        }
        return NO;
    } else {
        return YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.onScroll) {
        self.onScroll([self baseEvent]);
    }
}

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    TextViewNodeSpecs specs = ((VZFTextViewNode *)node).textViewNodeSpecs;
    self.textView.text = specs.text;
    self.textView.font = specs.getFont();
    self.textView.textColor = specs.color;
    self.textView.textAlignment = specs.alignment;
    self.placeholder = specs.placeholder;
    self.placeholderColor = specs.placeholderColor ?: [UIColor colorWithWhite:0.7 alpha:1.0];
    self.textView.editable = specs.editable.value;
    self.autoFocus = specs.autoFocus;
    self.textView.keyboardType = specs.keyboardType;
    self.textView.keyboardAppearance = specs.keyboardAppearance;
    self.textView.returnKeyType = specs.returnKeyType;
    self.maxLength = specs.maxLength.value;
    self.blurOnSubmit = specs.blurOnSubmit.value;
    self.textView.textContainerInset = node.flexNode.resultPadding;
    self.onFocus = specs.onFocus;
    self.onBlur = specs.onBlur;
    self.onChange = specs.onChange;
    self.onSubmit = specs.onSubmit;
    self.onEnd = specs.onEnd;
    [self updatePlaceholder];
    [self setNeedsLayout];
}

@end
