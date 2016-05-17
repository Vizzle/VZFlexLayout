//
//  VZFTextNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNode.h"
#import "VZFNodeInternal.h"
#import "VZFlexNode.h"
#import "VZFMacros.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeLayout.h"
#import "VZFTextNodeSpecs.h"

@implementation VZFTextNode
@synthesize textSpecs = _textSpecs;

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)newWithNodeSpecs:(const NodeSpecs &)specs TextAttributes:(const VZ::TextNodeSpecs &)textSpecs{

    VZFTextNode* textNode = [super newWithView:[UILabel class] NodeSpecs:specs];
    
    if (textNode) {
        textNode -> _textSpecs = textSpecs.copy();
        
        __weak typeof(textNode) weakNode = textNode;
        textNode.flexNode.measure = ^(CGSize constraintedSize) {
            
            __strong typeof(weakNode) strongNode = weakNode;
            
            if (!strongNode) {
                return CGSizeZero;
            }
            
            // 使用引用，这样 getFont() 缓存才有效果
            VZ::TextNodeSpecs& textSpecs = strongNode->_textSpecs;
            
            CGSize size = [textSpecs.getAttributedString() boundingRectWithSize:CGSizeMake(constraintedSize.width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            if (textSpecs.lines > 1) {
                NSAssert(textSpecs.attributedString == nil, @"'lines' is not supported on attributedString yet");
                CGFloat lineHeight = (textSpecs.getFont()?:[UIFont systemFontOfSize:[UIFont systemFontSize]]).lineHeight;
                size.height = std::min(size.height, lineHeight * textSpecs.lines);
            }
            
            CGFloat scale = [UIScreen mainScreen].scale;
            size.width = ceil(size.width * scale) / scale;
            size.height = ceil(size.height * scale) / scale;
            
            return size;
        };
    }
    return textNode;
}

@end
