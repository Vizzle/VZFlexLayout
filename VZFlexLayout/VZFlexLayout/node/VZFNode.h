//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeSpecs.h"
#import "VZFNodeViewClass.h"

using namespace VZ;
@interface VZFNode : NSObject

@property(nonatomic,assign,readonly)ViewClass viewClass;
@property(nonatomic,assign,readonly)NodeSpecs specs;

+(instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs& )specs;

- (id)nextResponder;

@end
