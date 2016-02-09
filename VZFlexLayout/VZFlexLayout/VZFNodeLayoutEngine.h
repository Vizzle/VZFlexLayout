//
//  VZFNodeLayoutEngine.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeLayout.h"
#import "VZFNodeFlexAttributes.h"
@interface VZFNodeLayoutEngine : NSObject

//pure function: (FlexAttributes) -> NodeLayout
- (VZ::NodeLayout)layout:(VZFlexAttributes) attrs;

@end
