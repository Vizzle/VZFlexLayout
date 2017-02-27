//
//  VZFStackView.m
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFStackView.h"
#import "VZFDispatch.h"

@implementation VZFStackView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    if(self.highlightColor){
        self.backgroundColor = self.highlightColor;
    }else{
        self.backgroundColor = self.defaultColor;
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    // 过一会儿再把背景颜色改回去，让用户能看到点击反馈
    VZFDispatchMain(0, ^{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = self.defaultColor;
    });
    
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    [super touchesCancelled:touches withEvent:event];
    
    if (!self.userInteractionEnabled) {
        return;
    }
    
    self.backgroundColor = self.defaultColor;
}


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)resetState
{
    self.backgroundColor = self.defaultColor;
}

@end
