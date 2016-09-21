//
//  VZFTextNodeTextKitContext.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/21.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNodeTextKitContext.h"
#import "VZFMacros.h"
#import "VZFLocker.h"
#import <libkern/OSAtomic.h>


@implementation VZFTextNodeTextKitContext

{
    // All TextKit operations (even non-mutative ones) must be executed serially.
    VZ::SpinLock _textKitSpinLock;
    
    
    //    NSLayoutManager *_layoutManager;
    //    NSTextStorage *_textStorage;
    //    NSTextContainer *_textContainer;
}
- (instancetype)initWithAttributedString:(NSAttributedString* )attributedString
                           lineBreakMode:(NSLineBreakMode)lineBreakMode
                    maximumNumberOfLines:(NSUInteger)maximumNumberOfLines
                         constrainedSize:(CGSize)constrainedSize{
    
    self = [super init];
    if (self) {
        
        VZ::SpinLocker l(_textKitSpinLock);
        
        _textStorage = (attributedString ? [[NSTextStorage alloc] initWithAttributedString:attributedString] : [[NSTextStorage alloc] init]);
        _layoutManager =  [[NSLayoutManager alloc] init];
        _layoutManager.usesFontLeading = NO;
        [_textStorage addLayoutManager:_layoutManager];
        
        _textContainer = [[NSTextContainer alloc] initWithSize:constrainedSize];
        _textContainer.lineFragmentPadding = 0;
        _textContainer.lineBreakMode = lineBreakMode;
        _textContainer.maximumNumberOfLines = maximumNumberOfLines;
        [_layoutManager addTextContainer:_textContainer];
        
        
    }
    return self;
    
}


//这个API唯一的意义就是对TextKit的操作加锁
- (void)performTextOperation:(void (^)(NSLayoutManager *,
                                       NSTextStorage *,
                                       NSTextContainer *))block
{
    VZ::SpinLocker l(_textKitSpinLock);
    
    if (block) {
        block(_layoutManager,_textStorage,_textContainer);
    }
    
}

@end
