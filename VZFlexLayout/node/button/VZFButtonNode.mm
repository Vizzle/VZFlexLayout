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
#import "VZFNodeLayout.h"
#import "VZFNodeSpecs.h"
#import "VZFButtonNodeSpecs.h"
#import "VZFButtonView.h"

@implementation VZFButtonNode

//@synthesize specs = _specs;
@synthesize buttonSpecs = _buttonSpecs;

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}
+ (instancetype)newWithButtonAttributes:(const ButtonNodeSpecs&) buttonSepcs NodeSpecs:(const NodeSpecs& )specs{
    
    VZFButtonNode* buttonNode = [super newWithView:[VZFButtonView class] NodeSpecs:specs];
    
    if (buttonNode) {
//        buttonNode -> _specs = specs;
        buttonNode -> _buttonSpecs = buttonSepcs.copy();
        
        __weak VZFButtonNode* weakNode = buttonNode;
        buttonNode.flexNode.measure = ^(CGSize constrainedSize) {
            __strong VZFButtonNode*  strongNode = weakNode;
            if (!strongNode) return CGSizeZero;
            
            VZ::ButtonNodeSpecs& buttonSpecs = strongNode->_buttonSpecs;
            
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            CGSize size = [buttonSpecs.title[UIControlStateNormal] boundingRectWithSize:CGSizeMake(constrainedSize.width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:buttonSpecs.getFont()?:[UIFont systemFontOfSize:[UIFont systemFontSize]], NSParagraphStyleAttributeName:style} context:nil].size;
            
            CGFloat scale = [UIScreen mainScreen].scale;
            size.width = ceil(size.width * scale) / scale;
            size.height = ceil(size.height * scale) / scale;
            
            UIImage *image = buttonSpecs.image[UIControlStateNormal];
            CGSize imageSize = image.size;
            
            return CGSizeMake(size.width + imageSize.width, MAX(size.height, imageSize.height));
        };
    }
    return buttonNode;
}
@end
