//
//  VZFRasterizeNodeTool.h
//  VZFlexLayout
//
//  Created by heling on 2017/2/10.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFRenderer.h"
#import "VZFNode.h"

@interface VZFRasterizeNodeTool : NSObject

+(VZFRenderer *)getRenderer4RasterizedNode:(VZFNode *)node size:(CGSize)size;

@end
