//
//  VZFStackNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFStackNode.h"

@implementation VZFStackNode
{
    VZFStackLayout _layout;
    std::vector<VZFStackChildNode> _children;
}

+ (instancetype)nodeWithStackLayout:(const VZFStackLayout& )layout Children:(const std::vector<VZFStackChildNode> &)children
{
    //create an empty node
    VZFStackNode* stacknode = [super nodeWithSpecs:{} FlexAttributes:{}];
    
    if (stacknode) {
        
        stacknode -> _layout = layout;
        stacknode -> _children = children;
    }

    return stacknode;
}


- (void)willMount{
    
    auto l =  _children.begin();
    for(;l != _children.end(); ++l){
        
    }

}


@end
