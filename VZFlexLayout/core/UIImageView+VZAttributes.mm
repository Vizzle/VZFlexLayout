//
//  UIImageView+VZAttributes.m
//  Pods
//
//  Created by heling on 2017/3/1.
//
//

#import "UIImageView+VZAttributes.h"
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFImageNodeBackingView.h"
#import "VZFImageNodeRenderer.h"

@implementation UIImageView (VZAttributes)


- (void)vz_applyNodeAttributes:(VZFImageNode *)imageNode{
    if (![imageNode isKindOfClass:[VZFImageNode class]]) {
        return;
    }
    
    ImageNodeSpecs imageSpec = imageNode.imageSpecs;
    id<VZFNetworkImageDownloadProtocol> imageDownloader = imageNode.imageDownloader;
    id<VZFNetworkImageDownloadProtocol> networkImageView = nil;
    
    //gif重复次数，context里拿到设置给imageView。setImage: 中会使用 animationRepeatCount，因此要先设置。
    NSDictionary *ctx = [imageSpec.context isKindOfClass:[NSDictionary class]] ? (NSDictionary *)imageSpec.context : @{};
    int animateCount = [ctx[@"animate-count"] intValue]?:0;
    
    // 这里不做判空，可能会在方法内做清理操作，避免复用可能会导致的图片错乱
    UIImage *downLoadImage = nil;
    if (imageNode.downloadImage && [imageNode.downloadImageUrl isEqualToString:imageSpec.imageUrl]) {
        downLoadImage = imageNode.downloadImage;
    }
    
    VZFImageNodeRenderer *renderer = nil;
    if ([self isKindOfClass:[VZFImageNodeBackingView class]]) {
        
        imageNode.renderer.animateCount = animateCount;
        imageNode.renderer.scale = self.contentScaleFactor;
        renderer = imageNode.renderer;
        
        VZFImageNodeBackingView *view = (VZFImageNodeBackingView *)self;
        view.imageRenderer = imageNode.renderer;
        view.contentMode = imageSpec.contentMode;
        
        networkImageView = view;
        
        if (imageSpec.imageUrl.length <= 0) {
            view.image = imageSpec.image;
        } else {
            view.image = nil;
        }
    } else {
        UIImageView<VZFNetworkImageDownloadProtocol>* view = (UIImageView<VZFNetworkImageDownloadProtocol>* )self;
        view.animationRepeatCount = animateCount;
        view.image = imageSpec.image;
        view.contentMode = imageSpec.contentMode;
        
        networkImageView = view;
    }
    
    if (downLoadImage) {
        
        NSArray *images = downLoadImage.images;
        NSTimeInterval duration = downLoadImage.duration;
        if (images.count && duration) {
            NSLog(@"1");
        }
        self.image = downLoadImage;
//            //gif
//            self.animationImages = images;
//            self.animationDuration = duration;
//            self.animationRepeatCount = self.animationRepeatCount ?: HUGE_VAL; //context里拿到直接设置
//            self.image = images.lastObject; //播放n次后显示最后一帧
//            [self startAnimating];
//        } else {
//            //非gif
//            //gif相关状态清理
//            [self stopAnimating];
//            self.animationImages = nil;
//            self.animationDuration = 0;
//            self.animationRepeatCount = 0;
//            
//            self.image = downLoadImage;
//        }
        return;
    }
    
    // 这里不做判空，可能会在方法内做清理操作，避免复用可能会导致的图片错乱
    //just call protocol
    
    //FIXED
    NSAssert(!imageSpec.imageUrl ||[imageSpec.imageUrl isKindOfClass:[NSString class]], @"ImageNodeSpecs imageUrl should be a string");
    
    if ([imageSpec.imageUrl isKindOfClass:[NSString class]]){
        if (imageDownloader && renderer) {
            [imageDownloader vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl] size:self.bounds.size contentMode:imageSpec.contentMode placeholderImage:imageSpec.image errorImage:imageSpec.errorImage context:imageSpec.context completionBlock:renderer];
        }else{
            [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                            size:self.bounds.size
                                     contentMode:imageSpec.contentMode
                                placeholderImage:imageSpec.image
                                      errorImage:imageSpec.errorImage
                                         context:imageSpec.context
                                 completionBlock:imageSpec.completion];
        }
    }
}
@end
