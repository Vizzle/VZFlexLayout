//
//  FBHeaderNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VZFlexLayout/VZFCompositeNode.h>
#import <VZFlexLayout/VZFNodeRequiredMethods.h>

@class FBHostItem;
@interface FBHeaderNode : VZFCompositeNode<VZFNodeRequiredMethods>

+ (instancetype)newWithProps:(id)props Store:(id)store Context:(id)context;

@end
