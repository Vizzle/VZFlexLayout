//
//  VZFTextRenderer.h
//  TextKitTest
//
//  Created by Sleen on 2016/12/1.
//  Copyright © 2016年 Sleen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFTextNodeSpecs.h"
#import "VZFRenderer.h"

@interface VZFTextNodeRenderer : VZFRenderer

@property (nonatomic, strong) NSAttributedString *text;
@property (nonatomic, assign) VZFTextLineBreakMode lineBreakMode;
@property (nonatomic, assign) VZFTextTruncationMode truncatingMode;
@property (nonatomic, assign) VZFTextVerticalAlignment verticalAlignment;
@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, assign) BOOL adjustsFontSizeToFitWidth;
@property (nonatomic, assign) CGFloat minimumScaleFactor;
@property (nonatomic, assign) UIBaselineAdjustment baselineAdjustment;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

- (CGSize)textSize;
// 目前主要做两端对齐，需要有真正显示的尺寸才能计算。为了把计算从主线程剥离，所以不在绘制时计算。
- (void)postLayout:(CGSize)size;
- (NSUInteger)linesCount;
- (CGFloat)firstBaselineInBounds:(CGRect)bounds;
- (CGFloat)lastBaselineInBounds:(CGRect)bounds;
- (NSInteger)characterIndexAtPoint:(CGPoint)point;

@end
