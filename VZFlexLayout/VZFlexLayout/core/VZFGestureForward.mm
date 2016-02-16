//
//  VZFGestureForward.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/13.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFGestureForward.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation VZFGestureForward
{
    NSMutableDictionary* _map;
}

- (id)init
{
    self = [super init];
    if (self) {
        _map = [@{} mutableCopy];
    }
    return self;
}
- (void)addGestureWithType:(NSString *)type Callback:(void (^)(id sender))callback{
    _map[type] = [callback copy];
}

- (void)action:(id)gesture{

    if (![gesture isKindOfClass:[UIGestureRecognizer class]]) {
        NSAssert(false, @"gestue type is incorrect!");
        return ;
    }
    NSString* key = NSStringFromClass([gesture class]);
    if (_map[key]) {
        void(^action)(id sender) = _map[key];
        action(gesture);
    }
}
@end

@implementation VZFNode(GestureForward)

const void* GestureForwardKey = &GestureForwardKey;

- (void)setGestureForward:(VZFGestureForward *)gestureForward{
    objc_setAssociatedObject(self, GestureForwardKey, gestureForward, OBJC_ASSOCIATION_RETAIN);
}
- (VZFGestureForward* )gestureForward{
    return objc_getAssociatedObject(self, GestureForwardKey);
}


@end