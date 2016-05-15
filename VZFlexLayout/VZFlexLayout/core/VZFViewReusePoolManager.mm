
//
//  VZFViewReuseManager.m
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFViewReusePoolManager.h"
#import "VZFNodeViewManager.h"
#import "VZFViewReusePool.h"
#import "VZFMacros.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"
#import <objc/runtime.h>
#import <vector>

static const void* g_viewReusePoolManager = &g_viewReusePoolManager;
@implementation VZFViewReusePoolManager
{
    NSMutableDictionary<NSString*, VZFViewReusePool* >* _reusePoolMap; //<ViewKey, ReusePool>
    std::vector<UIView* > _existedViews; //using vector to boost performance
}
+ (VZFViewReusePoolManager* )viewReusePoolManagerForView:(UIView* )view{
    
    id manager = objc_getAssociatedObject(view, g_viewReusePoolManager);
    if (!manager) {
        
        manager = [[VZFViewReusePoolManager alloc]init];
        objc_setAssociatedObject(view, g_viewReusePoolManager, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _reusePoolMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)reset:(UIView *)containerView{

    for(VZFViewReusePool* reusePool in [_reusePoolMap allValues]){
        [reusePool reset];
    }
    
    NSMutableArray* subviews = [[containerView subviews] mutableCopy];
    std::vector<UIView* >::const_iterator nextExistingViewPos = _existedViews.cbegin();
    

    for (int i=0; i<subviews.count; i++) {
        
        UIView* subview = subviews[i];
        
        //线性查找: 当前的subview在哪个reusePool里
        const auto &pos = std::find(nextExistingViewPos, _existedViews.cend(), subview);
    
        if (pos == _existedViews.cend()) {
            //忽略掉非node创建的view
            continue;
        }
        
        if(pos != nextExistingViewPos){
        
            NSUInteger swapIndex = [subviews indexOfObjectIdenticalTo:*nextExistingViewPos];
            VZFCAssert(swapIndex != NSNotFound, @"Expected to find view: %@ in %@",[*nextExistingViewPos class],[containerView class]);
            
            [subviews exchangeObjectAtIndex:i withObjectAtIndex:swapIndex];
            [containerView exchangeSubviewAtIndex:i withSubviewAtIndex:swapIndex];
        }
    
        ++nextExistingViewPos;
    }
    _existedViews.clear();
}

- (UIView* )viewForNode:(VZFNode* )node ParentView:(UIView* )container{
    if (!node.viewClass.hasView()) {
        return nil;
    }
    
    NSString* viewKey = [NSString stringWithFormat:@"%@-%@",NSStringFromClass(node.class),[[NSString alloc] initWithUTF8String:node.viewClass.identifier().c_str()]];
    VZFViewReusePool* reusePool = _reusePoolMap[viewKey];
    if (!reusePool) {
        reusePool = [[VZFViewReusePool alloc]init];
        _reusePoolMap[viewKey] = reusePool;
    }
    UIView* v = [reusePool viewForClass:node.viewClass ParentView:container];
    _existedViews.push_back(v);
    
    return v;
}
//
//- (UIView* )viewForClass:(const ViewClass&) viewclass Spec:(const NodeSpecs&)spec ParentView:(UIView* )container{
//
//    if (!viewclass.hasView()) {
//        return nil;
//    }
//    
//    //moxin: viewkey的计算不合理，后面优化
//    NSString* viewKey = [[NSString alloc] initWithUTF8String:viewclass.identifier().c_str()];
//    VZFViewReusePool* reusePool = _reusePoolMap[viewKey];
//    if (!reusePool) {
//        reusePool = [[VZFViewReusePool alloc]init];
//        _reusePoolMap[viewKey] = reusePool;
//    }
//    UIView* v = [reusePool viewForClass:viewclass ParentView:container];
//    _existedViews.push_back(v);
//    
//    return v;
//}

@end
