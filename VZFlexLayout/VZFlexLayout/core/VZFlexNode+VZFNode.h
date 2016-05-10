//
//  VZFlexNode+VZFNode.h
//  O2OReact
//
//  Created by moxin on 16/4/4.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFlexNode.h"

@class VZFNode;

/**
 *  give flexnode backwards access
 */
@interface VZFlexNode (VZFNode)

@property(nonatomic,assign)VZFNode* fNode;

@end
