//
//  VZFNetworkImageDownload.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VZFNetworkImageDownloadProtocol <NSObject>

@optional
- (id)downloadImageWithURL:(NSURL *)URL
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
         imageProcessBlock:(UIImage*(^)(UIImage* rawImage))imageProcessBlock
                completion:(void (^)(UIImage* image, NSError *error))completion;


- (void)cancelImageDownload:(id)download;

@end
