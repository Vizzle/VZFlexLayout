//
//  VZFSwitchNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"
#import "VZFActionWrapper.h"

namespace VZ {
    struct SwitchNodeSpecs {
        BOOL on;
        BOOL disabled;
        UIColor *onTintColor;
        UIColor *thumbTintColor;
        VZFBlockAction *action;

        SwitchNodeSpecs copy() const {
            return {
                on,
                disabled,
                onTintColor,
                thumbTintColor,
                action
            };
        }
    };
}
