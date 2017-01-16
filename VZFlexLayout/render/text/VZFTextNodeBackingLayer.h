//
//  VZFTextNodeBackingLayer.h
//  VZFlexLayout
//
//  Created by moxin on 16/9/18.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFAsyncLayer.h"

#import <UIKit/UIKit.h>



@class VZFTextNodeRenderer;
@interface VZFTextNodeBackingLayer : VZFAsyncLayer

@property(nonatomic,strong)VZFTextNodeRenderer* renderer;
@property(nonatomic,assign) UIEdgeInsets edgeInsets;

@end
