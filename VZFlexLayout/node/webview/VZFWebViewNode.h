//
//  VZFWebViewNode.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFNode.h"
#import "VZFWebViewNodeSpecs.h"

namespace VZ {
    class NodeSpecs;
    class WebViewNodeSpecs;
}

using namespace VZ;

@interface VZFWebViewNode : VZFNode

@property (nonatomic, assign, readonly) WebViewNodeSpecs webViewNodeSpecs;

+ (instancetype)newWithWebViewAttributes:(const WebViewNodeSpecs &)webViewNodeSpecs
                               NodeSpecs:(const NodeSpecs &)nodeSpecs;

@end
