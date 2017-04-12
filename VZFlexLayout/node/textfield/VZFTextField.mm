//
//  VZFTextField.m
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextField.h"
#import "UIView+VZAttributes.h"
#import "VZFTextFieldNode.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"

@interface VZFTextField () <UITextFieldDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign) BOOL submitted;

@end

@implementation VZFTextField

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectedTextRange"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxLength = NSUIntegerMax;
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(textFieldBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(textFieldEndEditing) forControlEvents:UIControlEventEditingDidEnd];
        [self addTarget:self action:@selector(textFieldSubmitEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addObserver:self forKeyPath:@"selectedTextRange" options:0 context:nil];
    }
    return self;
}

#pragma mark - Override

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(rect, self.contentInset);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    if (result) {
        if (self.onBlur) {
            self.onBlur([self baseEvent]);
        }
        [self.window removeGestureRecognizer:self.tapGesture];
    }
    return result;
}

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    if (result) {
        [self.window addGestureRecognizer:self.tapGesture];
    }
    return result;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (!newWindow) {
        [self.window removeGestureRecognizer:self.tapGesture];
    }
    [super willMoveToWindow:newWindow];
}

- (void)setPlaceholder:(NSString *)placeholder {
    super.placeholder = placeholder;
    [self updatePlaceholder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updatePlaceholder];
}

- (void)updatePlaceholder {
    if (self.placeholder.length > 0 && self.placeholderColor) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName : self.placeholderColor
                                                                                  }];
    } else if (self.placeholder.length) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.autoFocus && self.window) {
        [self becomeFirstResponder];
    }
}

#pragma mark - Events

- (NSMutableDictionary *)baseEvent {
    return [@{@"sender": self} mutableCopy];
}

- (void)textFieldDidChange {
    if (self.onChange) {
        self.onChange([self baseEvent]);
    }
}

- (void)textFieldBeginEditing {
    if (self.onFocus) {
        self.onFocus([self baseEvent]);
    }
    [self.window addGestureRecognizer:self.tapGesture];
}

- (void)textFieldEndEditing {
    if (self.onEnd) {
        self.onEnd([self baseEvent]);
    }
}

- (void)textFieldSubmitEditing {
    self.submitted = YES;
    if (self.onSubmit) {
        self.onSubmit([self baseEvent]);
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(VZFTextField *)textField
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedTextRange"]) {
        // For now, do nothing ...
    }
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.submitted) {
        self.submitted = NO;
        return self.blurOnSubmit;
    }
    return YES;
}

- (BOOL)textField:(VZFTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.maxLength == NSUIntegerMax
        || [string isEqualToString:@"\n"]) {
        return YES;
    }
    NSUInteger allowedLength = textField.maxLength - MIN(textField.maxLength, textField.text.length) + range.length;
    if (string.length > allowedLength) {
        if (string.length > 1) {
            NSString *limitedString = [string substringToIndex:allowedLength];
            NSMutableString *newString = textField.text.mutableCopy;
            [newString replaceCharactersInRange:range withString:limitedString];
            textField.text = newString;
            [self textFieldDidChange];
        }
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - Node spec attributes

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    TextFieldNodeSpecs specs = ((VZFTextFieldNode *)node).textFieldSpecs;
    self.text = specs.text;
    self.font = specs.getFont();
    self.textColor = specs.color;
    self.textAlignment = specs.alignment;
    self.placeholder = specs.placeholder;
    self.placeholderColor = specs.placeholderColor ?: [UIColor colorWithWhite:0.7 alpha:1.0];
    self.enabled = specs.editable.value;
    self.secureTextEntry = specs.secureTextEntry;
    self.keyboardType = specs.keyboardType;
    self.keyboardAppearance = specs.keyboardAppearance;
    self.returnKeyType = specs.returnKeyType;
    self.clearButtonMode = specs.clearButtonMode;
    self.maxLength = specs.maxLength.value;
    self.blurOnSubmit = specs.blurOnSubmit;
    self.autoFocus = specs.autoFocus.value;
    self.contentInset = node.flexNode.resultPadding;
    self.onFocus = specs.onFocus;
    self.onBlur = specs.onBlur;
    self.onChange = specs.onChange;
    self.onSubmit = specs.onSubmit;
    self.onEnd = specs.onEnd;
    [self setNeedsLayout];
}

@end
