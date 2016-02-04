//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUISpecs.h"
#import <unordered_map>

@interface VZFNode : NSObject

+(instancetype)nodeWithSpecs:(const VZ::UISpecs &)specs FlexAttributes:(const VZ::FlexAttribute &)attr;

+ (id)initialState;

- (void)updateState:(id(^)(id))updateBlock;

- (void)computeLayoutThatFits:(CGSize)sz;

- (void)render;



@end
