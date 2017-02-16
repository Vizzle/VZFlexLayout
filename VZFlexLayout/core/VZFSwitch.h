//
//  VZFSwitch.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"

@interface VZFSwitch : UISwitch

@property (nonatomic, copy) VZFEventBlock onChange;

@end
