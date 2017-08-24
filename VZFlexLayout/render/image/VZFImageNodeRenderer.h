//
//  VZFImageNodeRenderer.h
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VZFRenderer.h"
#import "VZFActionWrapper.h"
#import "VZFImageNode.h"


@interface VZFImageNodeRenderer : VZFRenderer <VZFActionWrapper>

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) BOOL isErrorImage;
@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) NSInteger animateCount;
@property (nonatomic, strong) NSString *downloadImageUrl;
@property(nonatomic, strong) VZFBlockAction* completion;

@end


@interface VZFImageNode()

@property(nonatomic,strong) NSString *downloadImageUrl;
@property(nonatomic,strong) UIImage *downloadImage;
@property(nonatomic,strong) UIImage *errorImage; //下载失败的时候有可能是因为url为空，但是一般判断的时候也会判断url是否相等，所以把errorImage的情况拎出来

@end
