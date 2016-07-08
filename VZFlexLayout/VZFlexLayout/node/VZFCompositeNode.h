//
//  VZFCompositeNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeCreationAPI.h"

/**
 *  Subclass node should inherit this node
 *
 *  Composite Node会作为responder chain的节点，传递事件
 */
@interface VZFCompositeNode : VZFNode<VZFNodeCreationAPI>

@property(nonatomic,strong,readonly)VZFNode* node;
@property(nonatomic,assign,readonly)BOOL childNodeHasBeenMounted;

+ (instancetype)newWithNode:(VZFNode* )node;

@end

@interface VZFCompositeNode(SubClassCreation)

+ (instancetype)newWithProps:(id)props Store:(id)store Context:(id)context;

@end
