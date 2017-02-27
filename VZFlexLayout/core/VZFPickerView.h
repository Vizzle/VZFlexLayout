//
//  VZFPickerView.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"

@interface VZFPickerView : UIPickerView

@property (nonatomic, copy) NSArray<NSString *> *items;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) VZFEventBlock onChange;


@end
