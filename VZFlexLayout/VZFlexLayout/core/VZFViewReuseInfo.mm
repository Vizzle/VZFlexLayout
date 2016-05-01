//
//  VZFViewReuseInfo.m
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFViewReuseInfo.h"

@implementation VZFViewReuseInfo
{
    UIView *__weak _view;
    void (^_didEnterReusePoolBlock)(UIView *);
    void (^_willLeaveReusePoolBlock)(UIView *);
    NSMutableArray<VZFViewReuseInfo* >* _childInfos;
    BOOL _hidden;
    BOOL _ancestorHidden;
}


- (instancetype)initWithView:(UIView *)view didEnterReusePoolBlock:(void (^)(UIView *))didEnterReusePoolBlock willLeaveReusePoolBlock:(void (^)(UIView *))willLeaveReusePoolBlock{
    
    if (self = [super init]) {
        
        _view = view;
        _didEnterReusePoolBlock     =  [didEnterReusePoolBlock copy];
        _willLeaveReusePoolBlock    =  [willLeaveReusePoolBlock copy];
        _childInfos = [NSMutableArray new];
    }
    return self;
}

- (void)addChildReuseInfo:(VZFViewReuseInfo* )info{
    [_childInfos addObject:info];
}

- (void)unHide{

    if (!_hidden) {
        return;
    }
    if (_ancestorHidden == NO && _willLeaveReusePoolBlock) {
        _willLeaveReusePoolBlock(_view);
    }
    _hidden = NO;
    
    for (VZFViewReuseInfo *descendantInfo in _childInfos) {
        [descendantInfo unHide];
    }
}

- (void)hide{

    if (_hidden) {
        return;
    }
    if (_ancestorHidden == NO && _didEnterReusePoolBlock) {
        _didEnterReusePoolBlock(_view);
    }
    _hidden = YES;
    
    for (VZFViewReuseInfo *descendantInfo in _childInfos) {
        [descendantInfo hide];
    }
}


@end
