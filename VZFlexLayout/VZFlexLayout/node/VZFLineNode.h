//
//  VZFLineNode.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFLineNodeSpecs.h"

@interface VZFLineNode : VZFNode

@property(nonatomic,assign,readonly) VZ::LineNodeSpecs lineSpecs;
+ newWithLineAttributes:(const VZ::LineNodeSpecs&)lineSpecs NodeSpecs:(const VZ::NodeSpecs&)specs;

@end
