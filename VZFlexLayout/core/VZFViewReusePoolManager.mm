
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
    VZFViewReusePoolMap *_reusePoolMap; //<ViewKey, ReusePool>
    std::vector<UIView* > _existedViews; //using vector to boost performance
    BOOL _isRoot;
}
+ (VZFViewReusePoolManager* )viewReusePoolManagerForView:(UIView* )view globalReusePoolMap:(VZFViewReusePoolMap*)globalReusePoolMap isRoot:(BOOL)isRoot {
    
    VZFViewReusePoolManager *manager = objc_getAssociatedObject(view, g_viewReusePoolManager);
    if (!manager) {
        manager = [[VZFViewReusePoolManager alloc]init];
        manager->_globalReusePoolMap = globalReusePoolMap;
        manager->_isRoot = isRoot;
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
    if (_isRoot) {
        for(VZFViewReusePool* reusePool in [_globalReusePoolMap allValues]){
            [reusePool reset];
        }
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
            if(swapIndex != NSNotFound){
                [subviews exchangeObjectAtIndex:i withObjectAtIndex:swapIndex];
                [containerView exchangeSubviewAtIndex:i withSubviewAtIndex:swapIndex];
            }
        }
    
        ++nextExistingViewPos;
    }
    _existedViews.clear();
}

- (UIView* )viewForNode:(VZFNode* )node ParentView:(UIView* )container Frame:(CGRect)frame {
    if (!node.viewClass.hasView()) {
        return nil;
    }

    NSString* viewKey;
    VZFViewReusePoolMap* reusePoolMap;
    if (node.specs.globalIdentifier.empty()) {
        viewKey = [[NSStringFromClass(node.class) stringByAppendingString:node.viewClass.identifier() ?: @""] stringByAppendingString:[NSString stringWithUTF8String:node.specs.identifier.c_str()]];
        reusePoolMap = _reusePoolMap;
    }
    else {
        viewKey = [[NSStringFromClass(node.class) stringByAppendingString:node.viewClass.identifier() ?: @""] stringByAppendingString:[NSString stringWithUTF8String:node.specs.globalIdentifier.c_str()]];
        reusePoolMap = _globalReusePoolMap;
    }
    VZFViewReusePool* reusePool = reusePoolMap[viewKey];

    if (!reusePool) {
        reusePool = [[VZFViewReusePool alloc] init];
        reusePoolMap[viewKey] = reusePool;
    }
    UIView* v = [reusePool viewForClass:node.viewClass ParentView:container Frame:frame];
    
    if (v) {
        _existedViews.push_back(v);
    }
   
    
    return v;
}


@end
