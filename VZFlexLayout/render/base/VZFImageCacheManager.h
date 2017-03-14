//
//  VZFImageCacheManager.h
//  O2OReact
//
//  Created by pep on 2017/3/9.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//只负责缓存的强持有，不负责缓存的分配
@interface VZFImageCacheManager : NSObject

+ (instancetype)sharedInstance;

- (void)storeContentsCache:(UIImage *)contents;

@end
