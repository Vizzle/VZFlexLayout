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
#import "VZFNodeLayout.h"

@interface VZFRasterizeNodeTool : NSObject


+ (VZFRenderer *)getRenderer4RasterizedNode:(VZFNode *)node size:(CGSize)size;

//获取layout树中，因为clip不能被光栅化的结点
+ (NSSet<VZFNode *> *)getClipAndCannotBeRasterizedNodes:(NodeLayout)layout;

@end
