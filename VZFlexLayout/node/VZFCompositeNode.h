//
//  VZFCompositeNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"

/**
 *  Subclass node should inherit this node
 *
 *  Composite Node会作为responder chain的节点，传递事件
 */
@interface VZFCompositeNode : VZFNode

@property(nonatomic,strong,readonly)VZFNode* node;

+ (instancetype)newWithNode:(VZFNode* )node;

@end
