//
//  VZFSegmentedControl.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/15.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"

@interface VZFSegmentedControl : UISegmentedControl

@property (nonatomic, copy) NSArray<NSString *> *items;
@property (nonatomic, copy) VZFEventBlock onChange;

@end
