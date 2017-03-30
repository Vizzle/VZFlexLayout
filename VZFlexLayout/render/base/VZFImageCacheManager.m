//
//  VZFImageCacheManager.m
//  O2OReact
//
//  Created by pep on 2017/3/9.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "VZFImageCacheManager.h"

@interface VZFImageCacheManager() {
    NSCache *_cache;
}

@end

@implementation VZFImageCacheManager

+ (instancetype)sharedInstance
{
    static VZFImageCacheManager* instance = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance = [VZFImageCacheManager new];
    });
    return instance;
}

- (void)storeContentsCache:(UIImage *)contents {
    if (![contents isKindOfClass:[UIImage class]]) {
        return;
    }
    
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 50;
    }
    
    NSString *key = [NSString stringWithFormat:@"%p", contents];
    [_cache setObject:contents forKey:key];
}

@end
