//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeSpecs.h"
#import "VZFNodeViewClass.h"

namespace VZ {
    class ViewClass;
    class NodeSpecs;
}

using namespace VZ;
@interface VZFNode : NSObject<NSCopying>

/**
 *  Create a Node
 *
 *  @param viewClass backing view
 *  @param specs     specification of the node
 * 
 */
+(instancetype)newWithView:(const ViewClass &)viewClass
                 NodeSpecs:(const NodeSpecs& )specs;


@end
