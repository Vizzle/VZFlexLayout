//
//  VZFButtonNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFButtonNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class ButtonNodeSpecs;
}
using namespace VZ;

@interface VZFButtonNode : VZFNode

@property(nonatomic,assign,readonly) ButtonNodeSpecs buttonSpecs;
+ (instancetype)newWithButtonAttributes:(const ButtonNodeSpecs&) buttonSepcs NodeSpecs:(const NodeSpecs& )specs;

@end
