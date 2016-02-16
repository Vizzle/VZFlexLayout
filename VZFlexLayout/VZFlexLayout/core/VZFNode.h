//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUISpecs.h"

using namespace VZ;
@interface VZFNode : NSObject

@property(nonatomic,assign,readonly)VZUISpecs specs;

+(instancetype)nodeWithUISpecs:(const VZUISpecs &)specs;



@end
