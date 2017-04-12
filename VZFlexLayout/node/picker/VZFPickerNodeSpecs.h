//
//  VZFPickerNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/14.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"
#import "VZFEvent.h"

namespace VZ {
    namespace DefaultAttributesValue {
        extern NSInteger selectedIndex;
    };
    
    struct PickerNodeSpecs {
        NSArray<NSString *> *items;
        Value<NSInteger, DefaultAttributesValue::selectedIndex> selectedIndex;
        /// Selected index changed event. Event body: {"selectedIndex": index}
        VZFEventBlock onChange;
        
        PickerNodeSpecs copy() const {
            return {
                [items copy],
                selectedIndex,
                [onChange copy]
            };
        }
    };
}
