//
//  VZFImageNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeUISpecs.h"

@interface VZFImageNode : VZFNode

@property(nonatomic,assign,readonly) VZUIImageNodeSpecs specs;
+ (instancetype)imageNodeWithSpecs:(const VZUIImageNodeSpecs& )specs;

@end
