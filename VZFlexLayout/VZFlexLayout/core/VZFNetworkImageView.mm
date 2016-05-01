//
//  VZFNetworkImageView.m
//  VZFlexLayout
//
//  Created by moxin on 16/2/27.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNetworkImageView.h"

@implementation VZFNetworkImageView{

}

- (void)vz_setImageWithURL:(NSURL *)url
                      size:(CGSize)sz
          placeholderImage:(UIImage *)loadingImage
                errorImage:(UIImage *)errorImage
                   context:(id)ctx completionBlock:(id<VZFActionWrapper>)completion{
    
    //todo: requires a default implementation
    
    
    
    if(completion){
        [completion invoke:self];
    }
    
    
}

- (void)enterReusePool{
   
    //todo

}


- (void)leaveReusePool{
  
    //todo

}



@end
