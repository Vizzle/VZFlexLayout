//
//  VZFNodeViewManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeLayout.h"
#import "VZFNodeViewClass.h"

@class VZFNode;
@interface VZFNodeViewManager : NSObject

@property(nonatomic,weak,readonly)UIView* managedView;

+ (UIView* )viewForNode:(VZFNode* )node withLayoutSpec:(const VZFNodeLayout&)layout reuseView:(UIView *)oldView;

- (instancetype)initWithView:(UIView* )view;

- (UIView* )viewForNode:(VZFNode* )node;


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