//
//  VZFButtonView.m
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFButtonView.h"

@implementation VZFButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _enlargeTouchSize = CGSizeZero;
        self.exclusiveTouch = YES;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGSizeEqualToSize(self.enlargeTouchSize, CGSizeZero))
    {
        return [super pointInside:point withEvent:event];
    }
    else
    {
        CGRect rect = CGRectInset(self.bounds, -self.enlargeTouchSize.width, -self.enlargeTouchSize.height);
        return CGRectContainsPoint(rect, point);
    }
}


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)resetState{
    _enlargeTouchSize = CGSizeZero;
}

@end
