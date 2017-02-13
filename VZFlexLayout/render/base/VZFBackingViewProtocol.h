//
//  VZFBackingViewProtocol.h
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/24.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFBaseRenderer.h"

@protocol VZFBackingViewProtocol <NSObject>

@required
- (__kindof VZFBaseRenderer *)renderer;
- (void)setLayerNeedsAsyncDisplay;

@end
