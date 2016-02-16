//
//  VZFNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeUISpecs.h"
#import "FlexLayout.h"

using namespace VZ;

typedef NS_OPTIONS(NSUInteger, NodeDescriptionOption) {
    NodeDescriptionOptionDefault = 0,
    NodeDescriptionOptionHideResult = 1 << 0,
    NodeDescriptionOptionHideUnspecified = 1 << 1,
    NodeDescriptionOptionHideChildren = 1 << 2,
};

@interface VZFNode : NSObject

@property(nonatomic,assign,readonly)VZUISpecs specs;

+(instancetype)nodeWithUISpecs:(const VZUISpecs &)specs;

- (NSString *)propertiesDescription:(NodeDescriptionOption)option;
- (NSString *)recursiveDescription:(NodeDescriptionOption)option;

@end
