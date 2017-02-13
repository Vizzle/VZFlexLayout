//
//  VZFButtonNodeBackingLayer.h
//  VZFlexLayout-Example
//
//  Created by heling on 2017/1/23.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFAsyncLayer.h"
#import "VZFButtonNodeRenderer.h"

@interface VZFButtonNodeBackingLayer : VZFAsyncLayer

@property(nonatomic,strong) VZFButtonNodeRenderer *renderer;
@end
