//
//  VZFNodeViewManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/1/30.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNode.h"

@interface VZFNodeViewManager : NSObject

+ (UIView* )viewForNode:(VZFNode* )node;

@end