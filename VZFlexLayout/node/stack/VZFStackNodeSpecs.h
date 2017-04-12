//
//  VZFStackNodeSpecs.h
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VZFLength.h"

namespace VZ {
    
    
    namespace DefaultStackAttributesValue{
        
        extern VZFlexLayoutWrapMode wrap;
        extern VZFlexLayoutDirection direction;
        extern VZFlexLayoutAlignment justifyContent;
        extern VZFlexLayoutAlignment alignItems;
        extern VZFlexLayoutAlignment alignContent;
        extern FlexLength spacing;
        extern FlexLength lineSpacing;
        
    }
    
    struct StackNodeSpecs{
        Value<VZFlexLayoutWrapMode, DefaultStackAttributesValue::wrap> wrap;
        unsigned int lines;
        unsigned int itemsPerLine;
        Value<VZFlexLayoutDirection, DefaultStackAttributesValue::direction> direction;
        Value<VZFlexLayoutAlignment, DefaultStackAttributesValue::justifyContent> justifyContent;
        Value<VZFlexLayoutAlignment, DefaultStackAttributesValue::alignItems> alignItems;
        Value<VZFlexLayoutAlignment, DefaultStackAttributesValue::alignContent> alignContent;
        Value<FlexLength, DefaultStackAttributesValue::spacing> spacing;
        Value<FlexLength, DefaultStackAttributesValue::lineSpacing> lineSpacing;
    };
    
}

