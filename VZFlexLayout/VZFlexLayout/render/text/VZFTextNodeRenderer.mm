//
//  VZFTextNodeRender.m
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFTextNodeRenderer.h"
#import "VZFTextNodeTextKitContext.h"
#import "VZFTextNodeTailTruncator.h"
#import "VZFLocker.h"
#import "VZFMacros.h"



static NSCharacterSet *vz_defaultAvoidTruncationCharacterSet()
{
    static NSCharacterSet *truncationCharacterSet = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        NSMutableCharacterSet *mutableCharacterSet = [[NSMutableCharacterSet alloc] init];
        [mutableCharacterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [mutableCharacterSet addCharactersInString:@".,!?:;"];
        truncationCharacterSet = mutableCharacterSet;
    });
    return truncationCharacterSet;
}


static inline NSAttributedString* vz_defaultTruncationString(){

    static NSAttributedString* string = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        string = [[NSAttributedString alloc]initWithString:@"..."];
    });
    return string;
    
}

static inline NSLineBreakMode vz_reduceLineBreakMode(NSLineBreakMode br){

    NSLineBreakMode mode ;
    switch (br) {
        case NSLineBreakByWordWrapping:
        case NSLineBreakByCharWrapping:
            mode = NSLineBreakByCharWrapping;
            break;
        case NSLineBreakByTruncatingTail:
        case NSLineBreakByClipping:
        case NSLineBreakByTruncatingHead:
        case NSLineBreakByTruncatingMiddle:
            mode = NSLineBreakByTruncatingTail;
            break;
        default:
            mode = NSLineBreakByTruncatingTail;
            break;
    }
    return mode;
}

static inline BOOL vz_nsstringContainsEmojiCharacter(NSString* textString){
    
    
    static NSCharacterSet* charSet = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        charSet = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
    });
    
    if ([textString rangeOfCharacterFromSet: charSet].location != NSNotFound) {
        return YES;
    }
    
    const unichar high = [textString characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [textString characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }

}



@implementation VZFTextNodeRenderer{
 
    CGSize _calculatedSize;
    CGSize _constrainedSize;
    VZFTextNodeTextKitContext* _textKitContext;
    VZFTextNodeTailTruncator* _textTailTruncator;
    NSAttributedString* _attribuetdString;
 
}

- (instancetype)initWithTextKitSpecs:(const TextNodeSpecs& )specs constraintSize:(CGSize)size{
    
    self = [super init];
    if (self) {
        _specs = specs;
        _constrainedSize = size;
        
        NSAttributedString* attribuetdString = specs.getAttributedString();
        _textKitContext = [[VZFTextNodeTextKitContext alloc]initWithAttributedString:attribuetdString
                                                               lineBreakMode:vz_reduceLineBreakMode(specs.lineBreakMode)
                                                        maximumNumberOfLines:specs.lines
                                                             constrainedSize:size];
        
        _textTailTruncator = [[VZFTextNodeTailTruncator alloc]initWithContext:_textKitContext
                                                  truncationAttributedString:[vz_defaultTruncationString() copy]                                                     avoidTailTruncationSet:vz_defaultAvoidTruncationCharacterSet()
                                                             constrainedSize:size];
        
        [self _calculateSize];
    }
    return self;
}

- (CGSize)textSize{
    
    return _calculatedSize;

}

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds{
    
    VZFAssertNotNil(context,@"Drawing Context Cannot be nil!");
    
    CGContextSaveGState(context);
    UIGraphicsPushContext(context);
    
 
    
    [_textKitContext performTextOperation:^(NSLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        
        NSRange glyphRange = [layoutManager glyphRangeForTextContainer:textContainer];
        CGPoint originPt = CGPointMake(bounds.origin.x, (bounds.size.height - _calculatedSize.height)/2);
        
        //draw text
        [layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:originPt];
        [layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:originPt];
        
        //todo:处理emoji显示，emoji
        /*
        [layoutManager enumerateLineFragmentsForGlyphRange:glyphRange usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange g, BOOL * _Nonnull stop) {
            NSString* lineString;
            if (textStorage.string.length >= (g.location + g.length)) {
                lineString = [textStorage.string substringWithRange:g];
                if ([self isIncludingEmoji:lineString]) {
                    [_layoutManager drawGlyphsForGlyphRange:g atPoint:CGPointMake(origin.x, origin.y + 2)];
                } else {
                    [_layoutManager drawGlyphsForGlyphRange:g atPoint:origin];
                }
            } else {
                [_layoutManager drawGlyphsForGlyphRange:g atPoint:origin];
            }
        }];
         */
        
        
    }];
    
    UIGraphicsPopContext();
    CGContextRestoreGState(context);
    

}

#pragma mark - private methods


- (void)_calculateSize
{
    [_textKitContext performTextOperation:^(NSLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        
        [layoutManager ensureLayoutForTextContainer:textContainer];
    }];
    
    CGRect constrainedRect = {CGPointZero, _constrainedSize};
    
    __block CGRect boundingRect;
    [_textKitContext performTextOperation:^(NSLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        
//        boundingRect = [layoutManager usedRectForTextContainer:textContainer];
        
        //moxin.xt:[layoutManager usedRectForTextContainer:textContainer]在numberOflines > 0 并且 有linespacing的场景时无法计算出正确的size，使用下面的API计算文字size:
        boundingRect = [layoutManager boundingRectForGlyphRange:[layoutManager glyphRangeForTextContainer:textContainer] inTextContainer:textContainer];
        
    }];
    
    //取交集
    boundingRect = CGRectIntersection(boundingRect, {.size = constrainedRect.size});
    
    _calculatedSize = boundingRect.size;
}


#pragma mark - String Ranges

- (NSUInteger)lineCount
{
    __block NSUInteger lineCount = 0;
    [_textKitContext performTextOperation:^(NSLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        for (NSRange lineRange = { 0, 0 }; NSMaxRange(lineRange) < [layoutManager numberOfGlyphs]; lineCount++) {
            [layoutManager lineFragmentRectForGlyphAtIndex:NSMaxRange(lineRange) effectiveRange:&lineRange];
        }
    }];
    return lineCount;
}


@end


