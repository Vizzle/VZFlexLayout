//
//  FBSampleNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/7/12.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFCompositeNode.h"
#import "VZFNodeRequiredMethods.h"

@interface FBSampleNode : VZFCompositeNode<VZFNodeRequiredMethods>

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx;

@end
