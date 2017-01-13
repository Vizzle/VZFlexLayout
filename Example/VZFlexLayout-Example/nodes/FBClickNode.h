//
//  FBClickNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/3/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"

@interface FBClickNode : VZFCompositeNode

+ (instancetype)newWithImage:(UIImage* )img Text:(NSString* )text Action:(SEL)action;

@end
