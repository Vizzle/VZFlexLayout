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

#import <objc/runtime.h>
#include <vector>


@implementation UIView (Unapply)

static const void* g_unapplicatorId = &g_unapplicatorId;

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
- (UIView* )viewForClass:(const ViewClass&)viewClass ParentView:(UIView* )container{
    
    UIView* v = nil;
    if (_nextUsableViewPos == _reusePool.end()) {
        //push a new one
        v = viewClass.createView();
        
        if (v) {
            
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
        
        // 重用前调用 unapplicator，避免残留脏数据
        [v unapply];
        
         VZ::Mounting::prepareForReuse(v);
//         VZFNSLog(@"[%@]-->create:<%@,%p> container:<%@,%p>",self.class,v.class,v,container.class,container);
        _nextUsableViewPos ++;
    }
    return v;

}
- (void)reset{
    for(auto itor = _reusePool.begin(); itor != _nextUsableViewPos; ++itor){
        
        UIView* view = *itor;
        VZ::Mounting::unhide(view);
        [view setHidden:NO];
    }
    
    for(auto itor = _nextUsableViewPos; itor != _reusePool.end(); ++itor){
        UIView* view = *itor;
        VZ::Mounting::hide(view);
        [view setHidden:YES];
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
