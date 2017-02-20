//
//  WebViewNodeViewController.m
//  VZFlexLayout-Example
//
//  Created by wuwen on 2017/2/20.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import "WebViewNodeViewController.h"
#import <VZFlexLayout/VZFlexLayout.h>

@interface WebViewNode : VZFCompositeNode <VZFNodeRequiredMethods>

@end

@implementation WebViewNode

+ (instancetype)newWithProps:(id)props Store:(VZFluxStore *)store Context:(id)ctx {
    VZFStackNode *node = [VZFStackNode newWithStackAttributes:{
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        {
            [VZFWebViewNode newWithWebViewAttributes:{
                .source = [props copy],
            }NodeSpecs:{
                .flexGrow = 1,
            }]
        }
    }];
    
    return [super newWithNode:node];
}

@end

@interface WebViewNodeViewController () <VZFNodeProvider>

@end

@implementation WebViewNodeViewController

- (NSDictionary *)initialState {
    return @{@"url": @"https://www.taobao.com"};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"VZFWebViewNode";
    
    self.hostingView = [[VZFNodeHostingView alloc] initWithNodeProvider:[self class] RangeType:VZFlexibleSizeNone];
    self.hostingView.frame = UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(64, 0, 0, 0));
    [self.hostingView update:self.state context:self];
    [self.view addSubview:self.hostingView];
}

#pragma mark - VZFNodeProvider

+ (VZFNode<VZFNodeRequiredMethods>* )nodeForItem:(id)item Store:(VZFluxStore* )store Context:(id)ctx {
    return [WebViewNode newWithProps:item Store:store Context:ctx];
}

@end
