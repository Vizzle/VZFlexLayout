//
//  VZStateHandler.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/22.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFNode;
@interface VZStateHandler : NSObject

+ (instancetype)stateHandlerForNode:(VZFNode* )node;

@end
