//
//  VZFRasterizeCacheDefine.h
//  O2OReact
//
//  Created by pep on 2017/3/16.
//  Copyright © 2017年 Alipay. All rights reserved.
//

//光栅化缓存的策略
typedef NS_OPTIONS(NSUInteger, VZFRasterizeCachePolicy) {
    VZFRasterizeCachePolicyNone = 0,
    VZFRasterizeCachePolicyNode = 1 << 0,    //使用node上的缓存
    VZFRasterizeCachePolicyLayer = 1 << 1,    //使用Layer上之前渲染的结果，如果也设置了VZFRasterizeCachePolicyNode，优先使用VZFRasterizeCachePolicyNode
    
};
