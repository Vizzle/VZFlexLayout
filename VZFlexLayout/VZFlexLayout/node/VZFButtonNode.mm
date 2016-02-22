//
//  VZFButtonNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFButtonNode.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFMacros.h"

@implementation VZFButtonNode

@synthesize specs = _specs;
@synthesize buttonSpecs = _buttonSpecs;

+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)newWithNodeSpecs:(const NodeSpecs& )specs ButtonAttributes:(const ButtonNodeSpecs&) buttonSepcs{
    
    VZFButtonNode* buttonNode = [super newWithView:[UIButton class] NodeSpecs:specs];
    
    if (buttonNode) {
        buttonNode -> _specs = specs;
        buttonNode -> _buttonSpecs = buttonSepcs.copy();
        
        __weak typeof(buttonNode) weakNode = buttonNode;
        buttonNode.flexNode.measure = ^(CGSize constraintedSize) {
            __strong typeof(weakNode) strongNode = weakNode;
            if (!strongNode) return CGSizeZero;
            
            VZ::ButtonNodeSpecs buttonSpecs = strongNode.buttonSpecs;
            
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = buttonSpecs.textAlignment;
            CGSize size = [buttonSpecs.title[UIControlStateNormal] boundingRectWithSize:CGSizeMake(constraintedSize.width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:buttonSpecs.font?:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:style} context:nil].size;
            
            CGFloat scale = [UIScreen mainScreen].scale;
            size.width = ceil(size.width * scale) / scale;
            size.height = ceil(size.height * scale) / scale;
            
            return size;
        };
    }
    return buttonNode;
}
@end
