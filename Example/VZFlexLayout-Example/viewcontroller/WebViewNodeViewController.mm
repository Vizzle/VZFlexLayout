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
        .direction = VZFlexVertical,
    } NodeSpecs:{
        .padding = 10,
    } Children:{
        {
            [VZFTextNode newWithTextAttributes:{
                .text = @"Load URL",
                .fontStyle = VZFFontStyleBold,
            } NodeSpecs:{
                .alignSelf = VZFlexStretch,
                .padding = 5,
                .backgroundColor = [UIColor lightGrayColor],
            }]
        },
        {
            [VZFWebViewNode newWithWebViewAttributes:{
                .source = [props[@"remote"] copy],
                .onLoadingStart = ^(NSDictionary *body) {
                    NSLog(@"LOADING STARTED:\n%@", body);
                },
                .onLoadingError = ^(NSDictionary *body) {
                    NSLog(@"LOADING FAILED:\n%@", body);
                },
                .onLoadingFinish = ^(NSDictionary *body) {
                    NSLog(@"LOADING FINISHED:\n%@", body);
                },
                .onShouldStartLoadWithRequest = ^(NSDictionary *body) {
                    NSLog(@"SHOULD LOAD REQUEST:\n%@", body);
                    return YES;
                }
            }NodeSpecs:{
                .flexGrow = 1,
            }]
        },
        {
            [VZFTextNode newWithTextAttributes:{
                .text = @"Load HTML",
                .fontStyle = VZFFontStyleBold,
            } NodeSpecs:{
                .alignSelf = VZFlexStretch,
                .marginTop = 10,
                .padding = 5,
                .backgroundColor = [UIColor lightGrayColor],
            }]
        },
        {
            
            [VZFWebViewNode newWithWebViewAttributes:{
                .source = [props[@"local"] copy],
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
    NSString *html = @"<!DOCTYPE html>"
    "<html>"
    "<head>"
    "<title></title>"
    "</head>"
    "<body>"
    "<h1>Hello React</h1>"
    "</body>"
    "</html>";
    
    return @{
             @"remote": @{@"url": @"https://www.taobao.com"},
             @"local": @{
                     @"html": html
                     }
             };
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
