//
//  VZFIndicatorNode.m
//  O2OReact
//
//  Created by Sleen on 16/6/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFIndicatorNode.h"
#import "VZFNodeSubClass.h"
#import "VZFNodeInternal.h"
#import "VZFIndicatorView.h"
#import "VZFMacros.h"
#import "VZFlexNode.h"

@implementation VZFIndicatorNode

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (id)newWithIndicatorAttributes:(const VZ::IndicatorNodeSpecs &)indicatorSpecs NodeSpecs:(const VZ::NodeSpecs &)specs {
    VZFIndicatorNode* indicatorNode = [super newWithView:[VZFIndicatorView class] NodeSpecs:specs];
    
    if (indicatorNode) {
        indicatorNode -> _indicatorSpecs = indicatorSpecs.copy();
        
        __weak VZFIndicatorNode* weakNode = indicatorNode;
        indicatorNode.flexNode.measure = ^(CGSize constrainedSize) {
            
            __strong VZFIndicatorNode* strongNode = weakNode;
            
            if (!strongNode) {
                return CGSizeZero;
            }
            
            return CGSize{ 20, 20 };
        };
    }
    return indicatorNode;
}

@end
