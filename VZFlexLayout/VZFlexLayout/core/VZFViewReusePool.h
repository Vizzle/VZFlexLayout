//
//  VZFViewReusePool.h
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VZFNodeViewClass.h"

@interface VZFViewReusePool : NSObject

/**
 *  从ReusePool中返回一个view
 *
 *  @param container 父容器
 *
 *  @return view对象
 */
- (UIView* )viewForClass:(const VZ::ViewClass&)viewClass ParentView:(UIView* )container;
- (void)reset;

@end
