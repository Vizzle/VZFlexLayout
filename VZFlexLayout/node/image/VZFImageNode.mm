//
//  VZFNetworkImageNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/16.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFImageNode.h"
#import "VZFMacros.h"
#import "VZFlexNode.h"
#import "VZFNodeInternal.h"
#import "VZFNetworkImageView.h"
#import "VZFNodeViewClass.h"
#import "VZFNodeLayout.h"
#import "VZFImageNodeSpecs.h"
#import "VZFImageNodeRenderer.h"
#import "VZFImageNodeInternal.h"

@implementation VZFImageNode
{
    
}
+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    
    VZ_NOT_DESIGNATED_INITIALIZER();

}

+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                             NodeSpecs:(const NodeSpecs& )nodeSpecs{

    
    return [VZFImageNode newWithImageAttributes:imageSpecs NodeSpecs:nodeSpecs BackingImageViewClass:[VZFNetworkImageView class]];

}



+ (instancetype)newWithImageAttributes:(const ImageNodeSpecs& )imageSpecs
                             NodeSpecs:(const NodeSpecs& )nodeSpecs
                 BackingImageViewClass:(Class<VZFNetworkImageDownloadProtocol>)backingImageViewClass{
    
    VZFImageNode* imageNode = [super newWithView:backingImageViewClass NodeSpecs:nodeSpecs];
    
    if (imageNode) {
        imageNode -> _imageSpecs = imageSpecs.copy();
        
        VZFImageNodeRenderer *renderer = [[VZFImageNodeRenderer alloc] init];
        renderer.contentMode = imageSpecs.contentMode;
        renderer.completion = imageSpecs.completion;

        imageNode -> _renderer = renderer;
        
        
        __weak VZFImageNode* weakNode = imageNode;
        imageNode.flexNode.measure = ^(CGSize constrainedSize) {
            __strong VZFImageNode* strongNode = weakNode;
            if (!strongNode) return CGSizeZero;
            
            const VZ::ImageNodeSpecs& imageSpecs = strongNode->_imageSpecs;
            return imageSpecs.image ? imageSpecs.image.size : CGSizeZero;
        };
    }

    return imageNode;
}

+ (instancetype)newWithImageAttributes:(const VZ::ImageNodeSpecs &)imageSpecs NodeSpecs:(const NodeSpecs &)nodeSpecs BackingImageViewClass:(Class<VZFNetworkImageDownloadProtocol>)backingImageViewClass ImageDownloader:(id<VZFNetworkImageDownloadProtocol>)imagedownloader ImageProcessingBlock:(UIImage *(^)(UIImage *))imageProcessingBlock{

    
    VZFImageNode* networkImageNode = [super newWithView:backingImageViewClass NodeSpecs:nodeSpecs];
    
    if (networkImageNode) {
        networkImageNode -> _imageSpecs = imageSpecs.copy();
        networkImageNode -> _imageDownloader = imagedownloader;
        networkImageNode -> _imageProcessingBlock = imageProcessingBlock;
        
        
        __weak VZFImageNode* weakNode = networkImageNode;
        networkImageNode.flexNode.measure = ^(CGSize constrainedSize) {
            __strong VZFImageNode* strongNode = weakNode;
            if (!strongNode) return CGSizeZero;
            
            VZ::ImageNodeSpecs imageSpecs = strongNode->_imageSpecs;
            return imageSpecs.image ? imageSpecs.image.size : CGSizeZero;
            
            
        };

        
    }
    return networkImageNode;
}

@end

