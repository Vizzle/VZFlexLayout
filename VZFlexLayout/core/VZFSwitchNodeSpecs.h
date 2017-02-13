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
        VZFBlockAction *action;

        SwitchNodeSpecs copy() const {
            return {
                on,
                action
            };
        }
    };
}
