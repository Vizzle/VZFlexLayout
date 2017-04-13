//
//  VZFNetworkImageNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNodeSpecs.h"
#import "VZFImageNodeSpecs.h"
#import "VZFNetworkImageDownloadProtocol.h"


using namespace VZ;
@class VZFImageNodeRenderer;

@interface VZFImageNode : VZFNode

@property(nonatomic,assign,readonly) ImageNodeSpecs imageSpecs;


+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                             NodeSpecs:(const NodeSpecs& )nodeSpecs;

+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                             NodeSpecs:(const NodeSpecs& )nodeSpecs
                 BackingImageViewClass:(Class<VZFNetworkImageDownloadProtocol>)backingImageViewClass;

+ (instancetype)newWithImageAttributes:(const VZ::ImageNodeSpecs &)imageSpecs
                             NodeSpecs:(const NodeSpecs &)nodeSpecs
                 BackingImageViewClass:(Class<VZFNetworkImageDownloadProtocol>)backingImageViewClass
                       ImageDownloader:(id<VZFNetworkImageDownloadProtocol>)imagedownloader
                  ImageProcessingBlock:(UIImage *(^)(UIImage *))imageProcessingBlock;

@end
