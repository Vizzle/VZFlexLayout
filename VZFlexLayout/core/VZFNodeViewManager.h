//
//  VZFNodeViewManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace VZ {
    class NodeLayout;
}
using namespace VZ;
@class VZFNode;
@class VZFRenderer;

/**
 *  管理node的backingview的subview的创建和复用
 */
@interface VZFNodeViewManager : NSObject

@property(nonatomic,weak,readonly)UIView* managedView;

@property(nonatomic,weak,readonly) VZFRenderer* managedRenderer;

- (instancetype)initWithView:(UIView* )view renderer:(VZFRenderer*)renderer;

- (UIView* )viewForNode:(VZFNode* )node;

- (VZFRenderer* )rendererForNode:(VZFNode* )node;

- (void)resetReusePool;

@end


@interface UIView(VZFNode)

@property(nonatomic,weak) VZFNode* node;

@end




@interface VZFNodeViewKey : NSObject

@property(nonatomic,strong,readonly)Class nodeClass;
@property(nonatomic,strong,readonly)NSString* identifier;

+ (VZFNodeViewKey* )viewKeyForNodeClass:(Class)nodeClass
                             Identifier:(NSString* )identifier;

@end