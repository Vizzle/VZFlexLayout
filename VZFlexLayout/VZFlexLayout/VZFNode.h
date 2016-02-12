//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUISpecs.h"

@interface VZFNode : NSObject
@property(nonatomic,assign,readonly)VZ::UISpecs specs;
+(instancetype)nodeWithUISpecs:(const VZ::UISpecs &)specs;

@end
