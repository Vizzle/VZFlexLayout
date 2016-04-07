//
//  VZFViewReuseInfo.h
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VZFViewReuseInfo : NSObject

- (instancetype)initWithView:(UIView *)view
      didEnterReusePoolBlock:(void (^)(UIView *))didEnterReusePoolBlock
     willLeaveReusePoolBlock:(void (^)(UIView *))willLeaveReusePoolBlock;

- (void)addChildReuseInfo:(VZFViewReuseInfo* )info;
- (void)unHide;
- (void)hide;
@end
