//
//  VZFNetworkImageNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFNetworkImageDownloadProtocol.h"

namespace VZ {
    class NodeSpecs;
    class ImageNodeSpecs;
}
using namespace VZ;
@interface VZFImageNode : VZFNode

@property(nonatomic,assign,readonly) ImageNodeSpecs imageSpecs;
@property(nonatomic,strong,readonly) id<VZFNetworkImageDownloadProtocol> imageDownloader;
@property(nonatomic, copy, readonly) UIImage*(^imageProcessingBlock)(UIImage* );


+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                             NodeSpecs:(const NodeSpecs& )nodeSpecs;

+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                             NodeSpecs:(const NodeSpecs& )nodeSpecs
                 BackingImageViewClass:(Class<VZFNetworkImageDownloadProtocol>)backingImageViewClass;
//                    ImageDownloader:(id<VZFNetworkImageDownloadProtocol>)imagedownloader
//                ImageProcessingBlock:(UIImage*(^)(UIImage* rawImage)) imageProcessingBlock;
@end
