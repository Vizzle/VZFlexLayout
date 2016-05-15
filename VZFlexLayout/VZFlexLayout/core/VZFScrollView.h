//
//  VZFScrollView.h
//  O2OReact
//
//  Created by moxin on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZFScrollView : UIScrollView

- (void)reset;
- (void)willEnterReusePool;
- (void)didLeaveReusePool;

@end
