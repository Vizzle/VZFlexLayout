//
//  VZFTextRenderer.h
//  TextKitTest
//
//  Created by Sleen on 2016/12/1.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    VZFTextLineBreakByWord,
    VZFTextLineBreakByChar,
} VZFTextLineBreakMode;

typedef enum : NSUInteger {
    VZFTextTruncatingTail,
    VZFTextTruncatingMiddle,
    VZFTextTruncatingHead,
    VZFTextTruncatingClip,
    VZFTextTruncatingNone,
} VZFTextTruncationMode;

typedef enum : NSUInteger {
    VZFTextVerticalAlignmentCenter,
    VZFTextVerticalAlignmentTop,
    VZFTextVerticalAlignmentBottom,
} VZFTextVerticalAlignment;

@interface VZFTextNodeRenderer : NSObject

@property (nonatomic, strong) NSAttributedString *text;
@property (nonatomic, assign) VZFTextLineBreakMode lineBreakMode;
@property (nonatomic, assign) VZFTextTruncationMode truncatingMode;
@property (nonatomic, assign) VZFTextVerticalAlignment verticalAlignment;
@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
@property (nonatomic, assign) CGFloat maxWidth;

- (CGSize)textSize;
- (CGFloat)firstBaselineInBounds:(CGRect)bounds;
- (CGFloat)lastBaselineInBounds:(CGRect)bounds;
- (void)drawInContext:(CGContextRef)context bounds:(CGRect)bounds;

@end
