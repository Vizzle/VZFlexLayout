//
//  VZFTextNodeBackingLayer.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFAsyncLayer.h"

@class VZFTextNodeRenderer;
@interface VZFTextNodeBackingLayer : VZFAsyncLayer

@property(nonatomic,strong)VZFTextNodeRenderer* renderer;

@end
