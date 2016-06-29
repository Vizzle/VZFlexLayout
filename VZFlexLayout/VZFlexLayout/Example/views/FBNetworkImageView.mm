//
//  FBNetworkImageView.m
//  VZFlexLayout
//
//  Created by moxin on 16/5/1.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBNetworkImageView.h"
#import "VZFActionWrapper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "VZFImageNode.h"
#import "VZFImageNodeSpecs.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeSubClass.h"

@implementation FBNetworkImageView
{
    BOOL _b;
}
- (void)vz_setImageWithURL:(NSURL *)url
                      size:(CGSize)sz
          placeholderImage:(UIImage *)loadingImage
                errorImage:(UIImage* )errorImage
                   context:(id)ctx
           completionBlock:(id<VZFActionWrapper>) completion{
    
    
    [self sd_setImageWithURL:url
            placeholderImage:loadingImage
                     options:0
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
       
//        if (completion) {
              
            [self resizeImage:image];
                                _b = YES;
//            [completion invoke:self event:nil];
//        }
    }];
    

}

- (void)resizeImage:(UIImage*) image{
    
    if (_b) {
        return;
    }
    CGFloat w = self.bounds.size.height * image.size.width / image.size.height;
    CGFloat h = self.bounds.size.height;
    
    CGSize sz= (CGSize){ w,h};
    
    [self.node updateState:^id(id oldstate) {
        
        return [NSValue valueWithCGSize:sz];
        
        
    } Mode:VZFActionUpdateModeSynchronous];
//
    
//    self.node
}

@end
