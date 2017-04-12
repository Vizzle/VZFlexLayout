//
//  VZFWebViewNode.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFWebViewNode.h"
#import "VZFWebView.h"

@implementation VZFWebViewNode

+ (instancetype)newWithWebViewAttributes:(const VZ::WebViewNodeSpecs &)webViewNodeSpecs NodeSpecs:(const VZ::NodeSpecs &)nodeSpecs {
    VZFWebViewNode *node = [VZFWebViewNode newWithView:[VZFWebView class] NodeSpecs:nodeSpecs];
    if (node) {
        node -> _webViewNodeSpecs = webViewNodeSpecs.copy();
    }
    return node;
}

@end
