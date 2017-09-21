//
//  VZFStackView.m
//  O2OReact
//
//  Created by moxin on 16/5/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFStackView.h"
#import "VZFDispatch.h"
#import <objc/runtime.h>


@implementation VZFStackView

- (NSString *)handlerForTouch:(UITouch *)touch {
    if (!touch) {
        return nil;
    }
    return objc_getAssociatedObject(touch, @selector(handlerForTouch:));
}

- (BOOL)checkSelfHandleTheTouch:(UITouch *)touch {
    NSString *handler =[self handlerForTouch:touch];
    NSString *selfStr = [NSString stringWithFormat:@"%p", self];
    return selfStr && [selfStr isEqualToString:handler];
}

- (void)setSelfHandleTheTouch:(UITouch *)touch {
    if (!touch) {
        return ;
    }
    objc_setAssociatedObject(touch, @selector(handlerForTouch:), [NSString stringWithFormat:@"%p", self], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    do {
        if (!self.userInteractionEnabled) {
            break;
        }
        
        if(self.highlightColor){
            UITouch *touch = [touches anyObject];
            if ([self handlerForTouch:touch]) {
                break;
            }
            
            [self setSelfHandleTheTouch:touch];
            
            self.backgroundColor = self.highlightColor;
        }else{
            self.backgroundColor = self.defaultColor;
        }
    } while (NO);
    
    [super touchesBegan:touches withEvent:event];

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    do {
        if (!self.userInteractionEnabled) {
            break;
        }
        
        UITouch *touch = [touches anyObject];
        if (![self checkSelfHandleTheTouch:touch]) {
            break;
        }
        
        __weak __typeof(self) weakSelf = self;
        // 过一会儿再把背景颜色改回去，让用户能看到点击反馈
        VZFDispatchMain(0, ^{
            //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                strongSelf.backgroundColor = strongSelf.defaultColor;
            }
        });
    } while (NO);
    
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    do {
        if (!self.userInteractionEnabled) {
            break;
        }
        
        UITouch *touch = [touches anyObject];
        if (![self checkSelfHandleTheTouch:touch]) {
            break;
        }
        
        
        self.backgroundColor = self.defaultColor;

    } while (NO);
    
    [super touchesCancelled:touches withEvent:event];
}


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)resetState
{
    self.backgroundColor = self.defaultColor;
}

@end
