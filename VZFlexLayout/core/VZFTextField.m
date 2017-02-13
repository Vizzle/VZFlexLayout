//
//  VZFTextField.m
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextField.h"

@interface VZFTextField () <UITextFieldDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation VZFTextField

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectedTextRange"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
        [self.eventHandler onEvent:VZFTextFieldEventTypeBlur sender:self];
        [self.window removeGestureRecognizer:self.tapGesture];
    }
    return result;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self.window removeGestureRecognizer:self.tapGesture];
    }
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - Events

- (void)textFieldDidChange {
    [self.eventHandler onEvent:VZFTextFieldEventTypeChange sender:self];
}

- (void)textFieldBeginEditing {
    [self.eventHandler onEvent:VZFTextFieldEventTypeFocus sender:self];
    [self.window addGestureRecognizer:self.tapGesture];
}

- (void)textFieldEndEditing {
    [self.eventHandler onEvent:VZFTextFieldEventTypeEnd sender:self];
}

- (void)textFieldSubmitEditing {
    [self.eventHandler onEvent:VZFTextFieldEventTypeSubmit sender:self];
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

- (BOOL)textField:(VZFTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!self.maxLength
        || [string isEqualToString:@"\n"]) {
        return YES;
    }
    NSUInteger allowedLength = textField.maxLength.integerValue - MIN(textField.maxLength.integerValue, textField.text.length) + range.length;
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

@end
