//
//  VZFButtonNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFButtonNodeSpecs.h"

@interface VZFButtonNode : VZFNode

@property(nonatomic,assign,readonly) NodeSpecs specs;
@property(nonatomic,assign,readonly) ButtonNodeSpecs buttonSpecs;
+ (instancetype)newWithNodeSpecs:(const NodeSpecs& )specs ButtonAttributes:(const ButtonNodeSpecs&) buttonSepcs;

@end
