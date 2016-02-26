//
//  VZFNodeController.h
//  VZFlexLayout
//
//  Created by Sleen on 16/2/25.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFNode;
@class UIView;

@interface VZFNodeController : NSObject

@property (nonatomic,weak,readonly) VZFNode *node;
@property (nonatomic,weak,readonly) UIView *view;

- (void)willUpdateNode          NS_REQUIRES_SUPER;
- (void)didUpdateNode           NS_REQUIRES_SUPER;

@end
