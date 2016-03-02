//
//  VZFNodeReuseUtility.m
//  VZFlexLayout
//
//  Created by 俞伟平 on 2/26/16.
//  Copyright © 2016 Vizlab. All rights reserved.
//

#import "VZFNodeReuseUtility.h"

#import <objc/runtime.h>
#import <unordered_map>

#import "VZFNodeViewConfiguration.h"
#import "VZFNodeViewClass.h"

using namespace VZ;

static char const kViewReuseInfoKey = ' ';

@interface VZFNodeViewReuseInfo : NSObject
- (instancetype)initWithView:(UIView *)view
      didEnterReusePoolBlock:(void (^)(UIView *))didEnterReusePoolBlock
     willLeaveReusePoolBlock:(void (^)(UIView *))willLeaveReusePoolBlock;
- (void)registerChildViewInfo:(VZFNodeViewReuseInfo *)info;
- (void)didHide;
- (void)willUnhide;
- (void)ancestorDidHide;
- (void)ancestorWillUnhide;
@end

void ViewReuseUtilities::mountingInRootView(UIView *rootView)
{
    // If we already mounted in this root view, it will already have a reuse info struct.
    if (objc_getAssociatedObject(rootView, &kViewReuseInfoKey)) {
        return;
    }
    
    VZFNodeViewReuseInfo *info = [[VZFNodeViewReuseInfo alloc] initWithView:rootView
                                                             didEnterReusePoolBlock:nil
                                                            willLeaveReusePoolBlock:nil];
    objc_setAssociatedObject(rootView, &kViewReuseInfoKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//void ViewReuseUtilities::createdView(UIView *view, const ViewClass &viewClass, UIView *parent)
//{
////    CKCAssertNil(objc_getAssociatedObject(view, &kViewReuseInfoKey),
////                 @"Didn't expect reuse info on just-created view %@", view);
//    
//    VZFNodeViewReuseInfo *info = [[VZFNodeViewReuseInfo alloc] initWithView:view
//                                                             didEnterReusePoolBlock:nil
//                                                            willLeaveReusePoolBlock:nil];
//    objc_setAssociatedObject(view, &kViewReuseInfoKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    VZFNodeViewReuseInfo *parentInfo = objc_getAssociatedObject(parent, &kViewReuseInfoKey);
////    CKCAssertNotNil(parentInfo, @"Expected parentInfo but found none on %@", parent);
//    [parentInfo registerChildViewInfo:info];
//}

void ViewReuseUtilities::mountingInChildContext(UIView *view, UIView *parent)
{
    // If this view was created by the components infrastructure, or if we've
    // mounted in it before, it will already have a reuse info struct.
    if (objc_getAssociatedObject(view, &kViewReuseInfoKey)) {
        return;
    }
    
    VZFNodeViewReuseInfo *info = [[VZFNodeViewReuseInfo alloc] initWithView:view
                                                             didEnterReusePoolBlock:nil
                                                            willLeaveReusePoolBlock:nil];
    objc_setAssociatedObject(view, &kViewReuseInfoKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    VZFNodeViewReuseInfo *parentInfo = objc_getAssociatedObject(parent, &kViewReuseInfoKey);
//    CKCAssertNotNil(parentInfo, @"Expected parentInfo but found none on %@", parent);
    [parentInfo registerChildViewInfo:info];
}

void ViewReuseUtilities::didHide(UIView *view)
{
    VZFNodeViewReuseInfo *info = objc_getAssociatedObject(view, &kViewReuseInfoKey);
//    CKCAssertNotNil(info, @"Expect to find reuse info on all components-managed views but found none on %@", view);
    [info didHide];
}

void ViewReuseUtilities::willUnhide(UIView *view)
{
    VZFNodeViewReuseInfo *info = objc_getAssociatedObject(view, &kViewReuseInfoKey);
//    CKCAssertNotNil(info, @"Expect to find reuse info on all components-managed views but found none on %@", view);
    [info willUnhide];
}

@implementation VZFNodeViewReuseInfo
{
    // Weak to prevent a retain cycle since the view holds the info strongly via associated objects
    UIView *__weak _view;
    void (^_didEnterReusePoolBlock)(UIView *);
    void (^_willLeaveReusePoolBlock)(UIView *);
    NSMutableArray *_childViewInfos;
    BOOL _hidden;
    BOOL _ancestorHidden;
}

- (instancetype)initWithView:(UIView *)view
      didEnterReusePoolBlock:(void (^)(UIView *))didEnterReusePoolBlock
     willLeaveReusePoolBlock:(void (^)(UIView *))willLeaveReusePoolBlock
{
    if (self = [super init]) {
        _view = view;
        _didEnterReusePoolBlock = didEnterReusePoolBlock;
        _willLeaveReusePoolBlock = willLeaveReusePoolBlock;
    }
    return self;
}

- (void)registerChildViewInfo:(VZFNodeViewReuseInfo *)info
{
    if (_childViewInfos == nil) {
        _childViewInfos = [[NSMutableArray alloc] init];
    }
    [_childViewInfos addObject:info];
}

- (void)didHide
{
    if (_hidden) {
        return;
    }
    if (_ancestorHidden == NO && _didEnterReusePoolBlock) {
        _didEnterReusePoolBlock(_view);
    }
    _hidden = YES;
    
    for (VZFNodeViewReuseInfo *descendantInfo in _childViewInfos) {
        [descendantInfo ancestorDidHide];
    }
}

- (void)willUnhide
{
    if (!_hidden) {
        return;
    }
    if (_ancestorHidden == NO && _willLeaveReusePoolBlock) {
        _willLeaveReusePoolBlock(_view);
    }
    _hidden = NO;
    
    for (VZFNodeViewReuseInfo *descendantInfo in _childViewInfos) {
        [descendantInfo ancestorWillUnhide];
    }
}

- (void)ancestorDidHide
{
    if (_ancestorHidden) {
        return;
    }
    if (_hidden == NO && _didEnterReusePoolBlock) {
        _didEnterReusePoolBlock(_view);
    }
    _ancestorHidden = YES;
    
    if (_hidden) {
        // Since this view is itself already hidden, no need to notify children. They already have _ancestorHidden = YES.
        return;
    }
    
    for (VZFNodeViewReuseInfo *descendantInfo in _childViewInfos) {
        [descendantInfo ancestorDidHide];
    }
}

- (void)ancestorWillUnhide
{
    if (!_ancestorHidden) {
        return;
    }
    if (_hidden == NO && _willLeaveReusePoolBlock) {
        _willLeaveReusePoolBlock(_view);
    }
    _ancestorHidden = NO;
    
    if (_hidden) {
        // If this view is itself still hidden, the unhiding of an ancestor changes nothing for children.
        return;
    }
    
    for (VZFNodeViewReuseInfo *descendantInfo in _childViewInfos) {
        [descendantInfo ancestorWillUnhide];
    }
}

@end

