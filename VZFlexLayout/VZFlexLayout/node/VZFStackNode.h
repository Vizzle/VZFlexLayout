//
//  VZFStackNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNode.h"
#import <vector>


typedef struct {
    VZFNode *node;
    NSUInteger spacingBefore; //not implemented yet
    NSUInteger spacingAfter;//not implemented yet
}VZFStackChildNode;


@interface VZFStackNode : VZFNode

@property(nonatomic,assign,readonly) std::vector<VZFStackChildNode> children;

+ (instancetype)newWithStackSpecs:(const NodeSpecs& )specs Children:(const std::vector<VZFStackChildNode> &)children;

@end
