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



@implementation VZFTextNode
@synthesize textSpecs = _textSpecs;

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (instancetype)newWithTextAttributes:(const TextNodeSpecs&) textSpecs NodeSpecs:(const NodeSpecs&) specs{
    
    VZFTextNode* textNode = [super newWithView:[VZFTextNodeBackingView class] NodeSpecs:specs];
    
    if (textNode) {
        textNode -> _textSpecs = textSpecs.copy();
        __block VZFTextNodeRenderer *renderer = [VZFTextNodeRenderer new];
        if (textSpecs.attributedString) {
            renderer.text = textSpecs.attributedString;
        }
        else {
            renderer.text = textSpecs.getAttributedString();
        }
        
        switch (textSpecs.lineBreakMode) {
            case NSLineBreakByTruncatingHead:
                renderer.truncatingMode = VZFTextTruncatingHead;
                break;
            case NSLineBreakByTruncatingMiddle:
                renderer.truncatingMode = VZFTextTruncatingMiddle;
                break;
            case NSLineBreakByTruncatingTail:
                renderer.truncatingMode = VZFTextTruncatingTail;
                break;
            case NSLineBreakByClipping:
                renderer.truncatingMode = VZFTextTruncatingClip;
                break;
            case NSLineBreakByCharWrapping:
                renderer.lineBreakMode = VZFTextLineBreakByChar;
                break;
            case NSLineBreakByWordWrapping:
                renderer.lineBreakMode = VZFTextLineBreakByWord;
                break;
        }
        renderer.maxNumberOfLines = textSpecs.lines;
        
        textNode -> _renderer = renderer;
        
        __weak typeof(textNode) weakNode = textNode;
        textNode.flexNode.measure = ^(CGSize constrainedSize) {
            
            __strong typeof(weakNode) strongNode = weakNode;
            
            if (!strongNode) {
                return CGSizeZero;
            }
            
            renderer.maxWidth = constrainedSize.width;
            CGSize size = [renderer textSize];
            size.width = MIN(size.width, constrainedSize.width);
            return size;
        };
    }
    return textNode;
}

@end
