//
//  VZFNodeViewManager.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeViewManager.h"
#import "VZFNode.h"
#import <objc/runtime.h>
#import "VZFViewReusePoolManager.h"
#import "VZFWeakObjectWrapper.h"
#import "VZFRenderer.h"

@implementation UIView(VZFNode)

static const void* g_nodeId = &g_nodeId;
- (void)setNode:(VZFNode *)node{
    VZFWeakObjectWrapper *wrapper = [[VZFWeakObjectWrapper alloc] init];
    wrapper.object = node;
    objc_setAssociatedObject(self, g_nodeId, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VZFNode* )node{
    VZFWeakObjectWrapper *wrapper = objc_getAssociatedObject(self, g_nodeId);
    if ([wrapper isKindOfClass:[VZFWeakObjectWrapper class]]
        && [wrapper.object isKindOfClass:[VZFNode class]]) {
        return wrapper.object;
    }
    return nil;
}

@end

using namespace VZ;

@implementation VZFNodeViewManager
{
    VZFViewReusePoolManager* _managerReusePoolManager;
}

- (instancetype)initWithView:(UIView* )view renderer:(VZFRenderer*)renderer {

    self = [super init];
    if (self) {
        _managedView = view;
        _managedRenderer = renderer;
        if (view) {
            _managerReusePoolManager = [VZFViewReusePoolManager viewReusePoolManagerForView:view];
        }
    }
    return self;
}

- (UIView* )viewForNode:(VZFNode* )node{

    UIView* v = [_managerReusePoolManager viewForNode:node ParentView:_managedView];
    return v;
    
}

- (VZFRenderer* )rendererForNode:(VZFNode* )node{
    return nil;
//    UIView* v = [_managerReusePoolManager viewForNode:node ParentView:_managedView];
//    return v;
    
}

- (void)resetReusePool {
    [_managerReusePoolManager reset:_managedView];
}

- (void)dealloc{
    
    NSLog(@"[%@]-->dealloc",self.class);
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

- (NSUInteger)hash {
    return [_identifier hash] ^ [_nodeClass hash];
}

@end
