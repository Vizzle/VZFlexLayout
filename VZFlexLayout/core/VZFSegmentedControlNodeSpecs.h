//
//  VZFSegmentControlSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/15.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFValue.h"

namespace VZ {
    namespace DefaultAttributesValue {
        extern BOOL enabled;
    };
    
    struct SegmentedControlNodeSpecs {
        NSArray<NSString *> *items;
        /// Selected segmented index changed event. Event body: {"selectedSegmentedIndex": index}
        VZFEventBlock onChange;
        NSInteger selectedSegmentedIndex;
        Value<BOOL, DefaultAttributesValue::enabled> enabled;
        
        SegmentedControlNodeSpecs copy() const {
            return {
                [items copy],
                [onChange copy],
                selectedSegmentedIndex,
                enabled
            };
        }
    };
}
