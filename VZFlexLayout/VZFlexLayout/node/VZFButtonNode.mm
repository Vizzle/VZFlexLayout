//
//  VZFButtonNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFButtonNode.h"
#import "VZFMacros.h"

@implementation VZFButtonNode

@synthesize specs = _specs;
@synthesize buttonSpecs = _buttonSpecs;

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)newWithNodeSpecs:(const NodeSpecs& )specs ButtonSpecs:(const ButtonNodeSpecs&) buttonSepcs{
    
    VZFButtonNode* buttonNode = [super newWithView:[UIButton class] NodeSpecs:specs];
    
    if (buttonNode) {
        buttonNode -> _specs = specs;
        buttonNode -> _buttonSpecs = buttonSepcs.copy();
    }
    return buttonNode;
}
@end
