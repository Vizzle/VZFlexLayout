//
//  VZFCompositeNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFState.h"


/**
 *  Subclass node should inherit this node
 */
@interface VZFCompositeNode : VZFNode

@property(nonatomic,strong,readonly)VZFNode* node;
+ (instancetype)newWithNode:(VZFNode* )node Props:(id<VZFProps>)props;

@end
