//
//  VZFWebView.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZFWebView : UIView

@property (nonatomic, strong, readonly) UIWebView *webView;
@property (nonatomic, copy) NSDictionary *source;

@end
