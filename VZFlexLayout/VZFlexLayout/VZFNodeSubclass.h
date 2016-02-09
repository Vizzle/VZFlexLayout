
//
//  VZFNodeSubclass.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/4.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#ifndef VZFNodeSubclass_h
#define VZFNodeSubclass_h

#import "VZFNode.h"
#import "VZFNodeLayout.h"

@interface VZFNode()

- (void)updateState:(id(^)(id))updateBlock;

- (VZFNodeLayout)computeLayoutThatFits:(CGSize)sz;

@end


#endif /* VZFNodeSubclass_h */
