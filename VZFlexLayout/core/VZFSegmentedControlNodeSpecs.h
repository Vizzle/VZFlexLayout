//
//  VZFSegmentControlSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/15.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFEvent.h"
#import "VZFNodeSpecs.h"

namespace VZ {
    
    struct SegmentedControlNodeSpecs {
        NSArray<NSString *> *items;
        /// Selected segmented index changed event. Event body: {"selectedSegmentedIndex": index}
        VZFEventBlock onChange;
        NSInteger selectedSegmentedIndex;
        Value<BOOL, DefaultControlAttrValue::able> enabled;
        
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
