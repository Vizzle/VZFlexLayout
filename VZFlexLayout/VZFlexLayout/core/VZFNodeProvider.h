//
//  VZFNodeProvider.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNodeCreationAPI.h"
@class VZFNode;
@class VZFluxStore;
@protocol VZFNodeProvider <NSObject>
- (VZFNode<VZFNodeCreationAPI>* )nodeForItem:(id)item Store:(id)store Context:(id)context;

@end
