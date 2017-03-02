//
//  VZFTextField.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"

@interface VZFTextField : UITextField

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

@end
