//
//  VZFTextField.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"

@interface VZFTextField : UITextField

@property (nonatomic, assign) NSNumber *maxLength;
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, copy) VZFEventBlock onFocus;
@property (nonatomic, copy) VZFEventBlock onBlur;
@property (nonatomic, copy) VZFEventBlock onChange;
@property (nonatomic, copy) VZFEventBlock onSubmit;
@property (nonatomic, copy) VZFEventBlock onKeyPress;
@property (nonatomic, copy) VZFEventBlock onEnd;

@end
