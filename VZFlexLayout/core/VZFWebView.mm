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
        _webView.delegate = self;
        [self addSubview:_webView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = self.bounds;
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

- (NSMutableDictionary<NSString *, id> *)baseEvent {
    NSMutableDictionary<NSString *, id> *event = [@{
                                                    @"url": self.webView.request.URL.absoluteString ?: @"",
                                                    @"loading" : @(self.webView.loading),
                                                    @"canGoBack": @(self.webView.canGoBack),
                                                    @"canGoForward" : @(self.webView.canGoForward),
                                                    } mutableCopy];
    
    return event;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    static NSDictionary<NSNumber *, NSString *> *navigationTypes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navigationTypes = @{
                            @(UIWebViewNavigationTypeLinkClicked): @"click",
                            @(UIWebViewNavigationTypeFormSubmitted): @"formsubmit",
                            @(UIWebViewNavigationTypeBackForward): @"backforward",
                            @(UIWebViewNavigationTypeReload): @"reload",
                            @(UIWebViewNavigationTypeFormResubmitted): @"formresubmit",
                            @(UIWebViewNavigationTypeOther): @"other",
                            };
    });
    
    BOOL shouldLoad = YES;
    if (self.onShouldStartLoadWithRequest) {
        NSMutableDictionary<NSString *, id> *event = [self baseEvent];
        [event addEntriesFromDictionary: @{
                                           @"url": (request.URL).absoluteString,
                                           @"navigationType": navigationTypes[@(navigationType)]
                                           }];
        shouldLoad = self.onShouldStartLoadWithRequest(event);
        if (!shouldLoad) {
            return NO;
        }
        
    }
    
    if (self.onLoadingStart) {
        NSMutableDictionary<NSString *, id> *event = [self baseEvent];
        [event addEntriesFromDictionary: @{
                                           @"url": (request.URL).absoluteString,
                                           @"navigationType": navigationTypes[@(navigationType)]
                                           }];
        self.onLoadingStart(event);
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.onLoadingFinish) {
        self.onLoadingFinish([self baseEvent]);
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (self.onLoadingError) {
        if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
            // NSURLErrorCancelled is reported when a page has a redirect OR if you load
            // a new URL in the WebView before the previous one came back. We can just
            // ignore these since they aren't real errors.
            // http://stackoverflow.com/questions/1024748/how-do-i-fix-nsurlerrordomain-error-999-in-iphone-3-0-os
            return;
        }
        
        NSMutableDictionary *event = [self baseEvent];
        [event addEntriesFromDictionary:@{
                                          @"domain": error.domain,
                                          @"code": @(error.code),
                                          @"description": error.localizedDescription,
                                          }];
        self.onLoadingError(event);
    }
}

#pragma mark - Node spec attributes

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    WebViewNodeSpecs specs = ((VZFWebViewNode *)node).webViewNodeSpecs;
    self.webView.scalesPageToFit = specs.scalesPageToFit;
    self.onLoadingStart = specs.onLoadingStart;
    self.onLoadingFinish = specs.onLoadingFinish;
    self.onLoadingError = specs.onLoadingError;
    self.onShouldStartLoadWithRequest = specs.onShouldStartLoadWithRequest;
    self.source = specs.source;
}

@end
