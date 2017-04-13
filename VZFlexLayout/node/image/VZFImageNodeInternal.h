//
//  VZFImageNodeInternal.h
//  VZFlexLayout
//
//  Created by pep on 2017/4/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#ifndef VZFImageNodeInternal_h
#define VZFImageNodeInternal_h

#import "VZFImageNode.h"

@interface VZFImageNode()

@property(nonatomic,strong,readonly) id<VZFNetworkImageDownloadProtocol> imageDownloader;
@property(nonatomic, copy, readonly) UIImage*(^imageProcessingBlock)(UIImage* );
@property(nonatomic,strong,readonly) VZFImageNodeRenderer *renderer;

@end

#endif /* VZFImageNodeInternal_h */
