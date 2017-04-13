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
#import "VZFTextNodeRenderer.h"
#import "VZFTextNodeBackingView.h"
#import "VZFTextNodeInternal.h"

@implementation VZFTextNode
@synthesize textSpecs = _textSpecs;

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)newWithTextAttributes:(const TextNodeSpecs&) textSpecs NodeSpecs:(const NodeSpecs&) specs{
    
    VZFTextNode* textNode = [super newWithView:[VZFTextNodeBackingView class] NodeSpecs:specs];
    
    if (textNode) {
        textNode -> _textSpecs = textSpecs.copy();
        VZFTextNodeRenderer *renderer = [VZFTextNodeRenderer new];

        renderer.text = textSpecs.getAttributedString();
        renderer.alignment = textSpecs.alignment;
        renderer.verticalAlignment = textSpecs.verticalAlignment;
        renderer.lineBreakMode = textSpecs.lineBreakMode;
        renderer.truncatingMode = textSpecs.truncationMode;
        renderer.maxNumberOfLines = textSpecs.lines;
        renderer.adjustsFontSizeToFitWidth = textSpecs.adjustsFontSize;
        renderer.minimumScaleFactor = textSpecs.miniScaleFactor;
        renderer.baselineAdjustment = textSpecs.baselineAdjustment;
        
        textNode -> _renderer = renderer;
        
        __weak VZFTextNode* weakNode = textNode;
        textNode.flexNode.measure = ^(CGSize constrainedSize) {
            
            __strong VZFTextNode* strongNode = weakNode;
            
            if (!strongNode) {
                return CGSizeZero;
            }
            
            // 使用引用，这样 getFont() 缓存才有效果
            VZ::TextNodeSpecs& textSpecs = strongNode->_textSpecs;
            
            // 当文字宽度超过 constrainedSize.width 时，会打省略号，此时 measure 的结果宽度可能会略小于 constrainedSize.width。这样可能会导致跟在它右边的文本有一个很小的宽度，而显示出小半个文字。为了处理这个问题，这里给 constrainedSize.width 变宽一点（这里是大约一个字的大小），再用 measure 结果跟 constrainedSize.width 取最小值。
            renderer.maxSize = CGSizeMake(textSpecs.lines == 1 ? constrainedSize.width + textSpecs.getFont().pointSize : constrainedSize.width, constrainedSize.height);
            CGSize size = [renderer textSize];
            size.width = MIN(size.width, constrainedSize.width);
            return size;
        };
        
        textNode.flexNode.baseline = ^(CGSize constrainedSize) {
            return constrainedSize.height - [renderer firstBaselineInBounds:CGRectMake(0, 0, constrainedSize.width, constrainedSize.height)];
        };
    }
    return textNode;
}

- (VZ::NodeLayout)nodeDidLayout {
    VZ::NodeLayout layout = [super nodeDidLayout];
    self.renderer.maxSize = CGSizeMake(layout.size.width - self.flexNode.resultPadding.left - self.flexNode.resultPadding.right, layout.size.height - self.flexNode.resultPadding.top - self.flexNode.resultPadding.bottom);
    // 主动触发文字计算尺寸
    [self.renderer postLayout:self.renderer.maxSize];
    return layout;
}

@end
