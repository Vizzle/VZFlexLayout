//
//  VZFViewReusePool.h
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    VZFViewReuseReusltNotReuse, // 不参与重用的 view
    VZFViewReuseReusltCreate,   // 没有可重用的 view，创建新 view
    VZFViewReuseReusltShow,     // 找到可重用的 view，并显示出来
    VZFViewReuseReusltHide,     // 不再需要的 view，隐藏起来以供重用
    VZFViewReuseReusltReuse,    // 找到可重用的 view，且已为显示状态
} VZFViewReuseReuslt;

@interface UIView (Unapply)

@property (nonatomic, copy) void(^unapplicator)(UIView* view);
@property (nonatomic, assign, readonly) VZFViewReuseReuslt reuseResult;
@property (nonatomic, assign, readonly) BOOL reuseShowing;

- (void)unapply;

@end


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
- (UIView* )viewForClass:(const ViewClass&)viewClass ParentView:(UIView* )container Frame:(CGRect)frame;
- (void)reset;
- (void)clean;

@end
