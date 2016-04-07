//
//  VZFNetworkImageNode.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFNetworkImageDownloadProtocol.h"


@interface VZFNetworkImageNode : VZFNode

//@property(nonatomic,copy,readonly)NSURL* url;
@property(nonatomic,assign,readonly)VZImageSpecs imageSpecs;
@property(nonatomic,strong,readonly)id<VZFNetworkImageDownloadProtocol> imageDownloader;
@property(nonatomic, copy, readonly) UIImage*(^imageProcessingBlock)(UIImage* );

+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                          NodeSpecs:(const NodeSpecs& )nodeSpecs
                    ImageDownloader:(id<VZFNetworkImageDownloadProtocol>)imagedownloader
                ImageProcessingBlock:(UIImage*(^)(UIImage* rawImage)) imageProcessingBlock;
@end
