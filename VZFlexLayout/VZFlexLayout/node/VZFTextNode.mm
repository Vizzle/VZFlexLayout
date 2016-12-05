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

+ (instancetype)newWithTextAttributes:(const TextNodeSpecs&) textSpecs NodeSpecs:(const NodeSpecs&) specs{
    
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
            
            // 当文字宽度超过 constraintedSize.width 时，会打省略号，此时 measure 的结果宽度可能会略小于 constraintedSize.width。这样可能会导致跟在它右边的文本有一个很小的宽度，而显示出小半个文字。为了处理这个问题，这里给 constraintedSize.width 变宽一点（这里是大约一个字的大小），再用 measure 结果跟 constraintedSize.width 取最小值。
            
            CGSize size = [textSpecs.getAttributedString() boundingRectWithSize:CGSizeMake(textSpecs.lines == 1 ? constraintedSize.width + textSpecs.getFont().pointSize : constraintedSize.width, constraintedSize.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            
            
            size.width = MIN(size.width, constraintedSize.width);
            

            
            if (textSpecs.lines > 1) {
                NSAssert(textSpecs.attributedString == nil, @"'lines' is not supported on attributedString yet");
                CGFloat lineHeight = (textSpecs.getFont()?:[UIFont systemFontOfSize:[UIFont systemFontSize]]).lineHeight;
                size.height = std::min(size.height, lineHeight * textSpecs.lines + textSpecs.lineSpacing * (textSpecs.lines - 1));
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
