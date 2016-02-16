//
//  VZFGestureForward.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/13.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VZFGestureForward : NSObject

- (void)addGestureWithType:(NSString* )type Callback:(void(^)(id sender))callback;
- (void)action:(id)sender;
@end

#import "VZFNode.h"
@interface VZFNode(GestureForward)
@property(nonatomic,strong) VZFGestureForward* gestureForward;

@end
