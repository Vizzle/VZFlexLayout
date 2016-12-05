//
//  VZFTextRenderer.m
//  TextKitTest
//
//  Created by Sleen on 2016/12/1.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#import "VZFTextNodeRenderer.h"
#import <CoreText/CoreText.h>


#define VZF_SCREEN_SCALE    ([UIScreen mainScreen].scale)
#define VZF_CEIL_PIXEL(v)   (ceil((v) * VZF_SCREEN_SCALE) / VZF_SCREEN_SCALE)
#define VZF_ROUND_PIXEL(v)  (round((v) * VZF_SCREEN_SCALE) / VZF_SCREEN_SCALE)


@interface VZFTextLine : NSObject

@property (nonatomic, strong) id line;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) CGFloat top;

@end
@implementation VZFTextLine
@end


@implementation VZFTextNodeRenderer
{
    BOOL _calculated;
    CGSize _textSize;
    NSArray<VZFTextLine *> *_lines;
}

- (void)setLineBreakMode:(VZFTextLineBreakMode)lineBreakMode {
    if (_lineBreakMode != lineBreakMode) {
        _calculated = NO;
    }
    _lineBreakMode = lineBreakMode;
}

- (void)setTruncatingMode:(VZFTextTruncationMode)truncatingMode {
    if (_truncatingMode != truncatingMode) {
        _calculated = NO;
    }
    _truncatingMode = truncatingMode;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    BOOL oldJustified = _alignment == NSTextAlignmentJustified;
    BOOL justified = alignment == NSTextAlignmentJustified;
    if (oldJustified != justified) {
        _calculated = NO;
    }
    _alignment = alignment;
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    if (_maxNumberOfLines != maxNumberOfLines) {
        _calculated = NO;
    }
    _maxNumberOfLines = maxNumberOfLines;
}

- (void)setMaxWidth:(CGFloat)maxWidth {
    if (_maxWidth != maxWidth) {
        _calculated = NO;
    }
    _maxWidth = maxWidth;
}

- (void)setText:(NSAttributedString *)text {
    // https://openradar.appspot.com/28522327
    // https://github.com/ibireme/YYText/issues/548#issuecomment-260231194
    BOOL isIOS10OrGreater = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 10}];
    if (isIOS10OrGreater) {
        NSMutableAttributedString *mutText = text.mutableCopy;
        [mutText fixAttributesInRange:NSMakeRange(0, mutText.length)];
        [mutText enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, mutText.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
            UIFont *font = (UIFont *)value;
            if ([font.fontName isEqualToString:@".AppleColorEmojiUI"]) {
                [mutText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleColorEmoji" size:font.pointSize] range:range];
            }
        }];
        text = mutText;
    }
    
    if (_text != text && ![_text isEqualToAttributedString:text]) {
        _calculated = NO;
    }
    _text = text;
}

- (CGSize)textSize {
    [self _calculate];
    return _textSize;
}

- (void)_calculate {
    if (_calculated) {
        return;
    }
    
    if (self.text.length == 0) {
        _calculated = YES;
        _textSize = CGSizeZero;
        return;
    }
    
    CFAttributedStringRef attrString = (__bridge CFAttributedStringRef)self.text;
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    CFIndex start = 0;
    NSUInteger textLength = self.text.length;
    NSUInteger maxRemainLines = self.maxNumberOfLines ?: UINT32_MAX;
    CGFloat width = 0;
    CGFloat height = 0;
    
    NSMutableArray *lines = [NSMutableArray array];
    while (start < textLength && maxRemainLines-- > 0) {
        CFIndex count;
        if (maxRemainLines == 0 && _truncatingMode != VZFTextTruncatingNone) {
            count = 0;
        }
        else {
            if (_lineBreakMode == VZFTextLineBreakByChar) {
                count = CTTypesetterSuggestClusterBreak(typesetter, start, self.maxWidth);
            }
            else {
                count = CTTypesetterSuggestLineBreak(typesetter, start, self.maxWidth);
            }
        }
        
        BOOL isFirstLine = start == 0;
        BOOL isLastLine = maxRemainLines == 0 || start + count >= textLength;
        BOOL needsToTruncate = _truncatingMode != VZFTextTruncatingClip && maxRemainLines == 0 && start + count < textLength;
        BOOL needsToJustify = _alignment == NSTextAlignmentJustified && start + count < textLength;
        
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        
        if (needsToTruncate) {
            // 省略号使用行末的字符的属性，当省略号在头部或中间时，得到的效果不一定正确
            CFIndex truncationTokenAttributesIndex = start + CTTypesetterSuggestClusterBreak(typesetter, start, self.maxWidth) - 1;
            NSDictionary *truncationTokenAttributes = [self.text attributesAtIndex:truncationTokenAttributesIndex effectiveRange:nil];
            NSAttributedString *tokenString = [[NSAttributedString alloc] initWithString:@"…" attributes:truncationTokenAttributes];
            CTLineRef truncationLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)tokenString);
            
            CTLineTruncationType type = _truncatingMode == VZFTextTruncatingHead ? kCTLineTruncationStart :
            _truncatingMode == VZFTextTruncatingMiddle ? kCTLineTruncationMiddle : kCTLineTruncationEnd;
            CTLineRef truncatedLine = CTLineCreateTruncatedLine(line, self.maxWidth, type, truncationLine);
            if (truncatedLine) {
                CFRelease(line);
                line = truncatedLine;
            }
            CFRelease(truncationLine);
        }
        
        if (needsToJustify) {
            CTLineRef justifiedLine = CTLineCreateJustifiedLine(line, 1, self.maxWidth);
            if (justifiedLine) {
                CFRelease(line);
                line = justifiedLine;
            }
        }
        
        VZFTextLine *textLine = [VZFTextLine new];
        textLine.line = (__bridge_transfer id)line;
        
        CGRect lineBounds = CTLineGetBoundsWithOptions(line, 0);
        textLine.bounds = lineBounds;
        CGFloat lineSpacing = 0;
        NSParagraphStyle *style = (__bridge NSParagraphStyle *)CFAttributedStringGetAttribute(attrString, start, kCTParagraphStyleAttributeName, NULL);
        if (style) {
            lineSpacing = style.lineSpacing;
        }
        
        if (!isFirstLine) {
            height += lineSpacing / 2;
        }
        textLine.top = height;
        height += lineBounds.size.height;
        if (!isLastLine) {
            height += lineSpacing / 2;
        }
        
        if (width < lineBounds.size.width) {
            width = lineBounds.size.width;
        }
        
        [lines addObject:textLine];
        start += count;
    }
    _lines = lines;
    
    _textSize = CGSizeMake(VZF_CEIL_PIXEL(width), VZF_CEIL_PIXEL(height));
    _calculated = YES;
    CFRelease(typesetter);
}

- (CGFloat)offsetYWithBounds:(CGRect)bounds {
    switch (_verticalAlignment) {
        case VZFTextVerticalAlignmentTop:
            return bounds.origin.y;
        default:
        case VZFTextVerticalAlignmentCenter:
            return bounds.origin.y + (bounds.size.height - _textSize.height) / 2;
        case VZFTextVerticalAlignmentBottom:
            return bounds.origin.y + (bounds.size.height - _textSize.height);
    }
}

- (CGFloat)baselineOfLineAtIndex:(NSUInteger)index inBounds:(CGRect)bounds {
    if (index >= _lines.count) {
        return bounds.size.height;
    }
    
    [self _calculate];
    
    VZFTextLine *textLine = [_lines objectAtIndex:index];
    CGFloat ascent;
    CTLineGetTypographicBounds((__bridge CTLineRef)textLine.line, &ascent, NULL, NULL);
    return ascent + textLine.top + [self offsetYWithBounds:bounds];
}

- (CGFloat)firstBaselineInBounds:(CGRect)bounds {
    return [self baselineOfLineAtIndex:0 inBounds:bounds];
}

- (CGFloat)lastBaselineInBounds:(CGRect)bounds {
    return [self baselineOfLineAtIndex:_lines.count - 1 inBounds:bounds];
}

- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds {
    if (self.text.length == 0) {
        return;
    }
    
    [self _calculate];
    
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGFloat offsetY = [self offsetYWithBounds:bounds];
    
    NSUInteger linesCount = _lines.count;
    for (int i=0;i<linesCount;i++) {
        VZFTextLine *textLine = _lines[i];
        
        CTLineRef line = (__bridge CTLineRef)textLine.line;
        CGRect lineBounds = textLine.bounds;
        CGFloat offsetX;
        switch (_alignment) {
            default:
            case NSTextAlignmentLeft:
                offsetX = bounds.origin.x;
                break;
            case NSTextAlignmentCenter:
                offsetX = bounds.origin.x + (bounds.size.width - lineBounds.size.width) / 2;
                break;
            case NSTextAlignmentRight:
                offsetX = bounds.origin.x + (bounds.size.width - lineBounds.size.width);
                break;
        }
        CGFloat x = offsetX + lineBounds.origin.x;
        CGFloat y = bounds.size.height - (offsetY + textLine.top + lineBounds.size.height);
        CGContextSetTextPosition(context, VZF_ROUND_PIXEL(x), VZF_ROUND_PIXEL(y - lineBounds.origin.y));
//        CGContextStrokeRect(context, CGRectMake(x, y, lineBounds.size.width, lineBounds.size.height));
        CTLineDraw(line, context);
    }
}

@end
