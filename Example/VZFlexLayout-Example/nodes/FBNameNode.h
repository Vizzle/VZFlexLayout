//
//  FBNameNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"

@interface FBNameNode : VZFCompositeNode

+ (instancetype)newWithName:(NSString* )name createTime:(NSString* )time  content:(NSString *)content;

@end
