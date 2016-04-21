//
//  VZFNodeProvider.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/20.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFNode;
@protocol VZFNodeProvider <NSObject>
- (VZFNode *)nodeForItem:(id<NSObject>)item context:(id<NSObject>)context;
@end
