//
//  VZFViewReuseManager.h
//  O2OReact
//
//  Created by moxin on 16/3/25.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFViewReusePool.h"

namespace VZ {
    class ViewClass;
    class NodeSpecs;
}
using namespace VZ;
@class VZFNode;

typedef NSMutableDictionary<NSString*, VZFViewReusePool* > VZFViewReusePoolMap;

/**
 *  管理每个view的ReusePool
 */
@interface VZFViewReusePoolManager : NSObject

@property (strong, readonly) VZFViewReusePoolMap* globalReusePoolMap;

+ (VZFViewReusePoolManager* )viewReusePoolManagerForView:(UIView* )view globalReusePoolMap:(VZFViewReusePoolMap*)globalReusePoolMap  isRoot:(BOOL)isRoot;

- (UIView* )viewForNode:(VZFNode* )node ParentView:(UIView* )container Frame:(CGRect)frame;
//- (UIView* )viewForClass:(const ViewClass&) viewclass Spec:(const NodeSpecs&)spec ParentView:(UIView* )container;
- (void)reset:(UIView* )containerView;

@end
