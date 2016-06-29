//
//  VZDynamicBlock.h
//  VZAsyncTemplate
//
//  Created by moxin.xt on 15-3-7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFTuple;

@interface VZDynamicBlock : NSObject

+ (id)invokeBlock:(id)block withArguments:(VZFTuple* )args;

@end
