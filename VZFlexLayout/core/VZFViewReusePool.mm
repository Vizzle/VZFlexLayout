//
//  VZFViewReusePool.m
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFViewReusePool.h"
#import "VZFUtils.h"
#import "VZFNodeViewClass.h"

#import "VZFMacros.h"
#import "VZFNodeBackingViewInterface.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeInternal.h"

#import <objc/runtime.h>
#include <vector>


@implementation UIView (Unapply)

static const void* g_unapplicatorId = &g_unapplicatorId;
static const void* g_reuseResultId = &g_reuseResultId;
static const void* g_reuseShowingId = &g_reuseShowingId;

- (void (^)(UIView *))unapplicator {
    return objc_getAssociatedObject(self, g_unapplicatorId);
}

- (void)setUnapplicator:(void (^)(UIView *))unapplicator {
    objc_setAssociatedObject(self, g_unapplicatorId, unapplicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)unapply {
    void(^unapplicator)(UIView* view) = self.unapplicator;
    if (unapplicator) {
        unapplicator(self);
        self.unapplicator = nil;
    }
}

- (VZFViewReuseReuslt)reuseResult {
    return (VZFViewReuseReuslt)[objc_getAssociatedObject(self, g_reuseResultId) intValue];
}

- (void)setReuseResult:(VZFViewReuseReuslt)reuseResult {
    objc_setAssociatedObject(self, g_reuseResultId, @(reuseResult), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)reuseShowing {
    return [objc_getAssociatedObject(self, g_reuseShowingId) boolValue];
}

- (void)setReuseShowing:(BOOL)reuseShowing {
    objc_setAssociatedObject(self, g_reuseShowingId, @(reuseShowing), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


@implementation VZFViewReusePool
{
    std::vector<UIView* > _reusePool;
    std::vector<UIView* >::iterator _nextUsableViewPos;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _nextUsableViewPos = _reusePool.begin();
    }
    return self;
}

- (UIView* )viewForClass:(const ViewClass&)viewClass ParentView:(UIView* )container Frame:(CGRect)frame {
    
    UIView* v = nil;
    if (_nextUsableViewPos == _reusePool.end()) {
        //push a new one
        v = viewClass.createView(frame);
        
        if (v) {
            v.reuseResult = VZFViewReuseReusltCreate;
            if (container) {
                [container addSubview:v];
                //            VZFNSLog(@"[%@]-->create:<%@,%p> container:<%@,%p>",self.class,v.class,v,container.class,container);
            }
            _reusePool.push_back(v);
            _nextUsableViewPos = _reusePool.end();
            VZ::Mounting::createView(v);
        }
    }
    else{
        //return an existing one
         v = *_nextUsableViewPos;
        if (viewClass.identifier()) {
            _nextUsableViewPos ++;

            if (!v.reuseShowing) {
                v.reuseResult = VZFViewReuseReusltShow;
            }
            else {
                v.reuseResult = VZFViewReuseReusltReuse;
            }

            // 重用前调用 unapplicator，避免残留脏数据
            [v unapply];

            if (v.superview != container) {
                v.frame = [v convertRect:v.bounds toView:container];
                [container addSubview:v];
            }

            VZ::Mounting::prepareForReuse(v);
//            VZFNSLog(@"[%@]-->create:<%@,%p> container:<%@,%p>",self.class,v.class,v,container.class,container);
        }
        else {
            // 如果 identifier 为空，不重用
            _nextUsableViewPos = _reusePool.erase(_nextUsableViewPos);
            [v removeFromSuperview];
            v = [self viewForClass:viewClass ParentView:container Frame:frame];
            v.reuseResult = VZFViewReuseReusltNotReuse;
        }
        
    }
    return v;
}

- (void)reset{

    for(auto itor = _reusePool.begin(); itor != _nextUsableViewPos; ++itor){
        
        UIView* view = *itor;
        VZ::Mounting::unhide(view);
        view.reuseShowing = YES;
    }
    for(auto itor = _nextUsableViewPos; itor != _reusePool.end(); ++itor){
        UIView* view = *itor;
        VZ::Mounting::hide(view);
        if (!view.hidden) {
            [view setHidden:YES];
            view.reuseResult = VZFViewReuseReusltHide;
            if (view.node) {
                [view.node.specs.updateDisappear invoke:view withCustomParam:view];
            }
        }
        view.reuseShowing = NO;
    }
    _nextUsableViewPos = _reusePool.begin();
}

- (void)clean{
    _reusePool.clear();
}

- (void)dealloc{
    [self clean];
}
@end
