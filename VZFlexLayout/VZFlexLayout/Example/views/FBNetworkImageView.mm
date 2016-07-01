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
       
       if (completion) {
            [completion invoke:self event:nil];
        }
    }];
    

}



@end
