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

@implementation UIImageView (VZAttributes)


- (void)vz_applyNodeAttributes:(VZFImageNode *)imageNode{
    if (![imageNode isKindOfClass:[VZFImageNode class]]) {
        return;
    }
    ImageNodeSpecs imageSpec = imageNode.imageSpecs;
    
    UIImageView<VZFNetworkImageDownloadProtocol>* networkImageView = (UIImageView<VZFNetworkImageDownloadProtocol>* )self;
    
    //gif重复次数，context里拿到设置给imageView。setImage: 中会使用 animationRepeatCount，因此要先设置。
    NSDictionary *ctx = [imageSpec.context isKindOfClass:[NSDictionary class]] ? (NSDictionary *)imageSpec.context : @{};
    int animateCount = [ctx[@"animate-count"] intValue]?:0;
    networkImageView.animationRepeatCount = animateCount;
    networkImageView.image = imageSpec.image;
    networkImageView.contentMode = imageSpec.contentMode;
    
    // 这里不做判空，可能会在方法内做清理操作，避免复用可能会导致的图片错乱
    //just call protocol

    if ([networkImageView respondsToSelector:@selector(vz_setImageWithURL:size:contentMode:placeholderImage:errorImage:context:completionBlock:)]) {
        [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                        size:self.bounds.size
                                 contentMode:imageSpec.contentMode
                            placeholderImage:imageSpec.image
                                  errorImage:imageSpec.errorImage
                                     context:imageSpec.context
                             completionBlock:imageSpec.completion];
    }else{
        [networkImageView vz_setImageWithURL:[NSURL URLWithString:imageSpec.imageUrl]
                                        size:self.bounds.size
                            placeholderImage:imageSpec.image
                                  errorImage:imageSpec.errorImage
                                     context:imageSpec.context
                             completionBlock:imageSpec.completion];
    }
    
}
@end
