//
//  VZFNetworkImageView.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNetworkImageView.h"
#import "VZFUtils.h"

@implementation VZFNetworkImageSpec


- (instancetype)initWithURL:(NSURL *)url defaultImage:(UIImage *)defaultImage imageProcessingFunc:(UIImage *(^)(UIImage *))imageProcessingBlock imageDownloader:(id<VZFNetworkImageDownloadProtocol>)imageDownloader{
    
    self = [super init];
    if (self) {
        
        _url = url;
        _defaultImage = defaultImage;
        _imageDownloader = imageDownloader;
        _imageProcessingBlock = [imageProcessingBlock copy];
    }
    return self;
}


- (NSUInteger)hash
{
    return [_url hash];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    } else if ([object isKindOfClass:[self class]]) {
        VZFNetworkImageSpec *other = object;
        return VZ::Hash::_ObjectsEqual(_url, other->_url)
        && VZ::Hash::_ObjectsEqual(_defaultImage, other->_defaultImage)
        && VZ::Hash::_ObjectsEqual(_imageDownloader, other->_imageDownloader);
    }
    return NO;
}

@end

@implementation VZFNetworkImageView{

    BOOL _isInReusePool;
    id _download;
}

- (void)dealloc{

    if (_download) {
        [self.spec.imageDownloader cancelImageDownload:_download];
        _download = nil;
    }
}

- (void)setSpec:(VZFNetworkImageSpec *)spec{

    if (VZ::Hash::_ObjectsEqual(spec, _spec)){
        return;
    }
    _spec = spec;

    if (_download) {
        [_spec.imageDownloader cancelImageDownload:_download];
        _download = nil;
    }
    
    self.image = spec.defaultImage;
    
    [self _startDownloadIfNotInReusePool];
    
    
}

- (void)enterReusePool{
    
    _isInReusePool = YES;
    if (_download) {
        [_spec.imageDownloader cancelImageDownload:_download];
        _download = nil;
    }
    self.image = self.spec.defaultImage;
}

- (void)leaveReusePool{
    _isInReusePool = NO;
    [self _startDownloadIfNotInReusePool];

}
- (void)_startDownloadIfNotInReusePool
{
    if (_isInReusePool || !_spec.url) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    _download = [_spec.imageDownloader downloadImageWithURL:_spec.url callbackQueue:dispatch_get_main_queue()downloadProgressBlock:nil imageProcessBlock:^UIImage *(UIImage *rawImage) {
        return weakSelf.spec.imageProcessingBlock(rawImage);
    } completion:^(UIImage* image, NSError *error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf _displayImage:image Error:error];
        }
    }];
}

- (void)_displayImage:(UIImage* )image Error:(NSError* )err{
    if (err) {
        //todo...
    }
    else{
        self.image = image;
        _download = nil;
    }
    
}
//
//- (void)updateContentsRect
//{
//    if (CGRectIsEmpty(self.bounds)) {
//        return;
//    }
//    
//    // If we're about to crop the width or height, make sure the cropped version won't be upscaled
//    CGFloat croppedWidth = self.image.size.width * _spec.cropRect.size.width;
//    CGFloat croppedHeight = self.image.size.height * _spec.cropRect.size.height;
//    if ((_spec.cropRect.size.width == 1 || croppedWidth >= self.bounds.size.width) &&
//        (_spec.cropRect.size.height == 1 || croppedHeight >= self.bounds.size.height)) {
//        self.layer.contentsRect = _spec.cropRect;
//    }
//}

@end
