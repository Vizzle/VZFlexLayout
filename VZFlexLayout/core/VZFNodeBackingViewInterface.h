//
//  UIView+VZFNodeBackingViewInterface.h
//  O2OReact
//
//  Created by moxin on 16/5/16.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VZFNodeBackingViewInterface <NSObject>

@optional

- (void)born;
- (void)dead;
- (void)resetState;
- (void)prepareForReuse;
- (void)willEnterReusePool;
- (void)didLeaveReusePool;

@end