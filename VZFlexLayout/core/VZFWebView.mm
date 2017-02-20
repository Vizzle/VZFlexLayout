//
//  VZFWebView.m
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "VZFWebView.h"
#import "UIView+VZAttributes.h"
#import "VZFWebViewNode.h"

@interface VZFWebView () <UIWebViewDelegate>

@end

@implementation VZFWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.delegate = self;
        [self addSubview:_webView];
    }
    return self;
}

- (void)setSource:(NSDictionary *)source {
    if ([_source isEqualToDictionary:source]) {
        return;
    }
    _source = [source copy];
    
    NSString *html = source[@"html"];
    if (html.length > 0) {
        NSURL *baseURL = [NSURL URLWithString:source[@"baseUrl"] ?: @""];
        if (!baseURL) {
            baseURL = [NSURL URLWithString:@"about:blank"];
        }
        [self.webView loadHTMLString:html baseURL:baseURL];
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:source[@"url"] ?: @""];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    if ([request.URL isEqual:self.webView.request.URL]) {
        return;
    }
    
    if (!request.URL) {
        [self.webView loadHTMLString:@"" baseURL:nil];
        return;
    }
    
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

#pragma mark - Node spec attributes

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    WebViewNodeSpecs specs = ((VZFWebViewNode *)node).webViewNodeSpecs;
    self.source = specs.source;
}

@end
