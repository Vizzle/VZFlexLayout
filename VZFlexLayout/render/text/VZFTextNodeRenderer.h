//
//  VZFTextRenderer.h
//  TextKitTest
//
//  Created by Sleen on 2016/12/1.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFTextNodeSpecs.h"
#import "VZFBaseRenderer.h"

@interface VZFTextNodeRenderer : VZFBaseRenderer

@property (nonatomic, strong) NSAttributedString *text;
@property (nonatomic, assign) VZFTextLineBreakMode lineBreakMode;
@property (nonatomic, assign) VZFTextTruncationMode truncatingMode;
@property (nonatomic, assign) VZFTextVerticalAlignment verticalAlignment;
@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) BOOL adjustsFontSizeToFitWidth;
@property (nonatomic, assign) CGFloat minimumScaleFactor;
@property (nonatomic, assign) UIBaselineAdjustment baselineAdjustment;

- (CGSize)textSize;
- (CGFloat)firstBaselineInBounds:(CGRect)bounds;
- (CGFloat)lastBaselineInBounds:(CGRect)bounds;


@end
