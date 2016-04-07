//
//  VZFNodeLayoutManager.h
//  O2OReact
//
//  Created by moxin on 16/3/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNodeLayout.h"

@class VZFNode;
@interface VZFNodeLayoutManager : NSObject

+ (instancetype)sharedInstance;

- (NSSet<VZFNode*>* )layoutRootNode:(const VZFNodeLayout& )layout
                        InContainer:(UIView* )container
                  WithPreviousNodes:(NSSet<VZFNode* >* )previousNodes
                       AndSuperNode:(VZFNode* )superNode;

- (void)unmountNodes:(NSSet<VZFNode* >* )nodes;

@end
