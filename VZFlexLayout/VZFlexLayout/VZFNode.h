//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUISpecs.h"
#import <unordered_map>

@interface VZFNode : NSObject

/**
 *  通过UISpecs来描述node
 *
 *  @return node instance
 */
+(instancetype)nodeWithSpecs:(const VZ::UISpecs &)specs FlexAttributes:(const VZ::FlexAttribute &)attr;
//+(instancetype)nodeWithSpecs:(const VZ::UISpecs &)specs FlexAttributes:(const VZ::FlexAttribute &)attr State:(id)state;

@end
