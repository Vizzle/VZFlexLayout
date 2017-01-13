//
//  VZFTextField.h
//  VZFlexLayout
//
//  Created by wuwen on 2016/12/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFTextFieldEventHandler.h"

@interface VZFTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, strong) VZFTextFieldEventHandler *eventHandler;

@end
