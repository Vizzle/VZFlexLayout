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

/**
 *  管理node的backingview的subview的创建和复用
 */
@interface VZFNodeViewManager : NSObject

@property(nonatomic,weak,readonly)UIView* managedView;

/**
 *  @param view
 *  @param shouldAutoReset 是否要自动对view进行reset
 */
- (instancetype)initWithView:(UIView* )view shouldAutoReset:(BOOL)shouldAutoReset;
- (instancetype)initWithView:(UIView *)view shouldAutoReset:(BOOL)shouldAutoReset parentManager:(VZFNodeViewManager *)parentManager;

- (UIView* )viewForNode:(VZFNode* )node frame:(CGRect)frame;

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
