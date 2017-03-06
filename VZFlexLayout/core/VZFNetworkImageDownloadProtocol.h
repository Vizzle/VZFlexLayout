//
//  VZFNetworkImageDownload.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/26.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFActionWrapper.h"

typedef void(^VZFNetworkImageCompletionBlock)(UIImage* img, NSError* err);


@protocol VZFNetworkImageDownloadProtocol <NSObject>


//- (id)downloadImageWithURL:(NSURL *)URL
//                      size:(CGSize)size
//             callbackQueue:(dispatch_queue_t)callbackQueue
//     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
//         imageProcessBlock:(UIImage*(^)(UIImage* rawImage))imageProcessBlock
//                completion:(VZFNetworkImageCompletionBlock)completion;
//
//
//- (void)cancelImageDownload:(id)download;
@optional
- (void)vz_setImageWithURL:(NSURL *)url
                      size:(CGSize)sz
          placeholderImage:(UIImage *)loadingImage
                errorImage:(UIImage* )errorImage
                   context:(id)ctx
           completionBlock:(id<VZFActionWrapper>) completion;


- (void)vz_setImageWithURL:(NSURL *)url
                      size:(CGSize)sz
               contentMode:(UIViewContentMode)contentMode
          placeholderImage:(UIImage *)loadingImage
                errorImage:(UIImage* )errorImage
                   context:(id)ctx
           completionBlock:(id<VZFActionWrapper>) completion;

@end

