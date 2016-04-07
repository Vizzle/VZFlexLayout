//
//  VZFViewReuseManager.h
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"
/**
 *  管理每个view的ReusePool
 */
using namespace VZ;
@interface VZFViewReusePoolManager : NSObject

+ (VZFViewReusePoolManager* )viewReusePoolManagerForView:(UIView* )view;

- (UIView* )viewForClass:(const ViewClass&) viewclass Spec:(const NodeSpecs&)spec ParentView:(UIView* )container;
- (void)reset:(UIView* )containerView;

@end
