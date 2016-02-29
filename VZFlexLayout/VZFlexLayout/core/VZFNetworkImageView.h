//
//  VZFNetworkImageView.h
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFNetworkImageDownloadProtocol.h"

@interface VZFNetworkImageSpec : NSObject
- (instancetype)initWithURL:(NSURL *)url
               defaultImage:(UIImage *)defaultImage
        imageProcessingFunc:(UIImage*(^)(UIImage* rawImage)) imageProcessingBlock
            imageDownloader:(id<VZFNetworkImageDownloadProtocol>)imageDownloader;


@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) UIImage*(^imageProcessingBlock)(UIImage* );
@property (nonatomic, strong, readonly) UIImage *defaultImage;
@property (nonatomic, strong, readonly) id<VZFNetworkImageDownloadProtocol> imageDownloader;
@end


@interface VZFNetworkImageView : UIImageView

@property(nonatomic,strong) VZFNetworkImageSpec* spec;

- (void)enterReusePool;
- (void)leaveReusePool;

@end
