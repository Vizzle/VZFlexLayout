//
//  FBImageDownloader.m
//  FBComponentListDemo
//
//  Created by moxin on 16/1/21.
//  Copyright © 2016年 VizLab. All rights reserved.
//

#import "FBImageDownloader.h"
#import <SDWebImage/SDWebImageDownloader.h>

@implementation FBImageDownloader

+ (instancetype)sharedInstance
{
    static FBImageDownloader* downloader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [FBImageDownloader new];
    });
    return downloader;
}
- (id)downloadImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue downloadProgressBlock:(void (^)(CGFloat))downloadProgressBlock imageProcessBlock:(UIImage *(^)(UIImage *))imageProcessBlock completion:(void (^)(UIImage* , NSError *))completion{

    id<SDWebImageOperation> op =  [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        if (finished) {
            dispatch_async(callbackQueue, ^{
                
                if (image && completion) {
                    completion(image,error);
                }
                
            });
        }
        
        
    }];
    return op;

}


- (void)cancelImageDownload:(id)download
{
    id<SDWebImageOperation> op = (id<SDWebImageOperation>) download;
    [op cancel];
}

@end
