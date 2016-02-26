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

+ (VZFNetworkImageNode* )newWithURL:(NSURL* )url
                    ImageAttributes:(const ImageNodeSpecs& )imageSpecs
                          NodeSpecs:(const NodeSpecs& )nodeSpecs
                    ImageDownloader:(id<VZFNetworkImageDownloadProtocol>)imagedownloader;

@end
