//
//  VZFViewReusePool.h
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



namespace VZ {
    class ViewClass;
}
using namespace VZ;
@interface VZFViewReusePool : NSObject

/**
 *  从ReusePool中返回一个view
 *
 *  @discussion：todo:补充复用规则
 *
 *  @param container 父容器
 *
 *  @return view对象
 */
- (UIView* )viewForClass:(const ViewClass&)viewClass ParentView:(UIView* )container;
- (void)reset;
- (void)clear;

@end
