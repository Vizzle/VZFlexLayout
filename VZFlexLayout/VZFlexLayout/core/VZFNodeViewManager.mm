//
//  VZFNodeViewManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeViewManager.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeSpecs.h"
#import "VZFCompositeNode.h"
#import "VZFStackNode.h"
#import "VZFImageNode.h"
#import "VZFTextNode.h"
#import "VZFButtonNode.h"
#import "VZFNetworkImageNode.h"
#import "VZFNetworkImageView.h"
#import <objc/runtime.h>
#import "VZFNodeControllerInternal.h"
#import "VZFActionWrapper.h"
#import "VZFViewReusePoolManager.h"
#import "VZFNodeLayout.h"
#import "VZFTextNodeSpecs.h"
#import "VZFImageNodeSpecs.h"
#import "VZFButtonNodeSpecs.h"


@implementation UIView(VZFNode)

static const void* g_nodeId = &g_nodeId;
- (void)setNode:(VZFNode *)node{
    objc_setAssociatedObject(self, g_nodeId, node, OBJC_ASSOCIATION_ASSIGN);
}

- (VZFNode* )node{
    return objc_getAssociatedObject(self, g_nodeId);
}

@end

using namespace VZ;

@implementation VZFNodeViewManager
{
    VZFViewReusePoolManager* _reusePoolManager;
}

- (instancetype)initWithView:(UIView *)view{

    self = [super init];
    if (self) {
        _managedView = view;
        _reusePoolManager = [VZFViewReusePoolManager viewReusePoolManagerForView:view];
    }
    return self;
}

- (UIView* )viewForNode:(VZFNode* )node{

//    UIView* v = [_reusePoolManager viewForClass:node.viewClass Spec:node.specs ParentView:_managedView];
    UIView* v=  [_reusePoolManager viewForNode:node ParentView:_managedView];
    return v;
}

- (void)dealloc{
    [_reusePoolManager reset:_managedView];
}


@end


@implementation VZFNodeViewKey
{
    
}

+ (VZFNodeViewKey* )viewKeyForNodeClass:(Class)nodeClass Identifier:(NSString* )identifier{
    
    VZFNodeViewKey* viewKey = [VZFNodeViewKey new];
    viewKey->_identifier = [identifier copy];
    viewKey->_nodeClass  = nodeClass;
    
    return viewKey;
}


- (BOOL)isEqual:(VZFNodeViewKey* )object
{
    return [self->_identifier isEqualToString:object.identifier] && (self ->_nodeClass == object.nodeClass);
}


@end