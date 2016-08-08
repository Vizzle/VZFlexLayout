//
//  VZFNodeProvider.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeRequiredMethods.h"

@class VZFNode;
@class VZFluxStore;
@protocol VZFNodeProvider <NSObject>

//make it immutable, no side effect
+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx;


@end
