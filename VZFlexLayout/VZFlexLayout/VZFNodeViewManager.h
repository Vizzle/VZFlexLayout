//
//  VZFNodeViewManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeUISpecs.h"
#import "VZFNodeMountContext.h"

@interface VZFNodeViewManager : NSObject

+ (void)registerNodeWithMountedContext:(const VZ::NodeMountedContext &)context;

+ (UIView* )viewForConfiguration:(const VZ::UISpecs &)specs;

@end