//
//  FBScrollChildNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/5/17.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <VZFlexLayout/VZFCompositeNode.h>
#import <VZFlexLayout/VZFNodeRequiredMethods.h>
#import "FBHostItem.h"

@interface FBScrollChildNode : VZFCompositeNode<VZFNodeRequiredMethods>

+ (instancetype)newWithProps:(FBScrollItem* )props Store:(VZFluxStore *)store Context:(id)ctx;

@end
