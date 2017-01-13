//
//  FBImageDownloader.h
//  FBComponentListDemo
//
//  Created by moxin on 16/1/21.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFNetworkImageDownloadProtocol.h"

@interface FBImageDownloader : NSObject<VZFNetworkImageDownloadProtocol>

+ (instancetype)sharedInstance;

@end
