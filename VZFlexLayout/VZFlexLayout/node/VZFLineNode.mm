//
//  VZFLineNode.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFLineNode.h"
#import "VZFNodeSubClass.h"
#import "VZFNodeInternal.h"
#import "VZFLineView.h"

using namespace VZ;
@implementation VZFLineNode

+ (id)newWithLineAttributes:(const VZ::LineNodeSpecs &)lineSpecs NodeSpecs:(const VZ::NodeSpecs &)specs {
    
    VZFLineNode* lineNode = [super newWithView:[VZFLineView class] NodeSpecs:specs];
    
    if (lineNode) {
        lineNode -> _lineSpecs = lineSpecs.copy();
    }
    
    return lineNode;
}

@end
