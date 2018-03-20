//
//  VZFActionWrapper.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFActionWrapper.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeSubClass.h"
#import "VZFTextNodeBackingView.h"
#import <libkern/OSAtomic.h>

@implementation VZFBlockWrapper
- (instancetype)initWithBlock:(UIControlActionBlock)block {
    if (self = [super init]) {
        self.block = block;
        
        //moxin.xt:
        //add a memory fence
        //force the block to be copied
        OSMemoryBarrier();
    }
    return self;
}

- (void) dealloc {
    self.block = nil;
}

- (void) invoke:(UIControl *)sender event:(UIEvent *)event {
    
    //moxin.xt: wired crash at this line :
    //libobjc.A.dylib 0x0000000182d8c0b0 objc_retain + 16
    if (self.block) {
        self.block(sender);
    }
}

- (void)invoke:(UIControl *)sender withCustomParam:(id)param{
    
    if (self.block) {
        self.block(param);
    }
}

- (void)invoke:(UIGestureRecognizer *)sender {
    if (sender.class == UILongPressGestureRecognizer.class && sender.state != UIGestureRecognizerStateBegan) {
        return;
    }

    // 点击文本中的链接时不触发 tap gesture
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UIView *view = [sender.view hitTest:[sender locationInView:sender.view] withEvent:nil];
        if ([view isKindOfClass:[VZFTextNodeBackingView class]]) {
            if ([(VZFTextNodeBackingView *)view containsLinkAtPoint:[sender locationInView:view]]) {
                return;
            }
        }
    }

    if (self.block) {
        self.block(sender.view);
    }
}

@end


@implementation VZFBlockAction

- (instancetype)initWithControlEvents:(UIControlEvents)controlEvents block:(UIControlActionBlock)block {
    if (self = [super initWithBlock:block]) {
        _controlEvents = controlEvents;
    }
    return self;
}

+ (instancetype)actionWithControlEvents:(UIControlEvents)controlEvents block:(UIControlActionBlock)block {
    return [[self alloc] initWithControlEvents:controlEvents block:block];
}

+ (instancetype)action:(UIControlActionBlock)block {
    return [self actionWithControlEvents:UIControlEventTouchUpInside block:block];
}

@end


@implementation VZFBlockGesture

- (instancetype)initWithClass:(Class)gestureClass block:(UIControlActionBlock)block {
    NSAssert([gestureClass isSubclassOfClass:[UIGestureRecognizer class]], @"");
    if (self = [super initWithBlock:block]) {
        _gestureClass = gestureClass;
    }
    return self;
}

+ (instancetype)gestureWithClass:(Class)gestureClass block:(UIControlActionBlock)block {
    return [[self alloc] initWithClass:gestureClass block:block];
}

+ (instancetype)tapGesture:(UIControlActionBlock)block {
    return [self gestureWithClass:[UITapGestureRecognizer class] block:block];
}

+ (instancetype)longPressGesture:(UIControlActionBlock)block {
    return [self gestureWithClass:[UILongPressGestureRecognizer class] block:block];
}

@end

