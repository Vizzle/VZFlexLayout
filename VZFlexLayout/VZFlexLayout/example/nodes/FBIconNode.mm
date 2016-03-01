//
//  FBIconNode.m
//  VZFlexLayout
//
//  Created by moxin on 16/3/1.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "FBIconNode.h"
#import "VZFNetworkImageNode.h"
#import "FBImageDownloader.h"

@implementation FBIconNode

+ (instancetype)newWithURL:(NSURL* )url{
    
    
    VZFNetworkImageNode* iconNode = [VZFNetworkImageNode newWithURL:url
                                                    ImageAttributes:{.contentMode = UIViewContentModeScaleAspectFill}
                                                          NodeSpecs:{
                                                              .view = {
                                                                  .clipToBounds = YES,
                                                                  .backgroundColor = [UIColor grayColor],
                                                                  .layer = {.cornerRadius = 20.0f}
                                                              },
                                                              .flex = {
                                                                  .width = 40,
                                                                  .height = 40
                                                              }}
                                                    ImageDownloader:[FBImageDownloader sharedInstance]
                                               ImageProcessingBlock:nil];

    return [super newWithNode:iconNode];

}


@end
