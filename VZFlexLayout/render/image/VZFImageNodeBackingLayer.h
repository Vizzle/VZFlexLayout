//
//  VZFImageNodeBackingLayer.h
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFAsyncLayer.h"
#import <UIKit/UIKit.h>

@class VZFImageNodeRenderer;

@interface VZFImageNodeBackingLayer : VZFAsyncLayer

@property(nonatomic,strong) VZFImageNodeRenderer* renderer;

@end
