//
//  VZFNetworkImageNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNetworkImageNode.h"
#import "VZFMacros.h"
#import "VZFlexNode.h"
#import "VZFNodeInternal.h"
#import "VZFNetworkImageView.h"

@implementation VZFNetworkImageNode
{
    
}
+ (instancetype)newWithView:(ViewClass &&)viewClass NodeSpecs:(const NodeSpecs &)specs{
    
    VZ_NOT_DESIGNATED_INITIALIZER();

}

+ (instancetype)newWithURL:(NSURL *)url ImageAttributes:(const VZ::ImageNodeSpecs &)imageSpecs NodeSpecs:(const NodeSpecs &)nodeSpecs ImageDownloader:(id<VZFNetworkImageDownloadProtocol>)imagedownloader ImageProcessingBlock:(UIImage *(^)(UIImage *))imageProcessingBlock{
    
    VZFNetworkImageNode* networkImageNode = [super newWithView:[VZFNetworkImageView class] NodeSpecs:nodeSpecs];
    
    if (networkImageNode) {
        networkImageNode -> _url = url;
        networkImageNode -> _imageSpecs = imageSpecs.copy();
        networkImageNode -> _imageDownloader = imagedownloader;
        networkImageNode -> _imageProcessingBlock = imageProcessingBlock;
        
        
        __weak typeof(networkImageNode) weakNode = networkImageNode;
        networkImageNode.flexNode.measure = ^(CGSize constraintedSize) {
            __strong typeof(weakNode) strongNode = weakNode;
            if (!strongNode) return CGSizeZero;
            
            VZ::ImageNodeSpecs imageSpecs = strongNode->_imageSpecs;
            return imageSpecs.image ? imageSpecs.image.size : CGSizeZero;
            
            
        };

        
    }
    return networkImageNode;
}

@end

