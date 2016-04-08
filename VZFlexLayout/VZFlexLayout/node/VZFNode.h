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

/**
 *  Create a Node
 *
 *  @param viewClass backing view
 *  @param specs     specification of the node
 * 
 */
+(instancetype)newWithView:(ViewClass &&)viewClass
                 NodeSpecs:(const NodeSpecs& )specs;
/**
 *  nextResponder of Node
 *
 *  1, Node's controller
 *  2, Node's parent node
 *  3, Hosting view if this node is the root node
 *
 */
- (id)nextResponder;

@end
