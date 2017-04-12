//
//  VZFTextView.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"

@interface VZFTextView : UIView

@property (nonatomic, strong, readonly) UITextView *textView;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, assign) BOOL blurOnSubmit;
@property (nonatomic, assign) BOOL autoFocus;
@property (nonatomic, copy) VZFEventBlock onFocus;
@property (nonatomic, copy) VZFEventBlock onBlur;
@property (nonatomic, copy) VZFEventBlock onChange;
@property (nonatomic, copy) VZFEventBlock onSubmit;
@property (nonatomic, copy) VZFEventBlock onEnd;
@property (nonatomic, copy) VZFEventBlock onScroll;

@end
