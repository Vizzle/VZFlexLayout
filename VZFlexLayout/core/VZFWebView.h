//
//  VZFWebView.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFEvent.h"

@interface VZFWebView : UIView

@property (nonatomic, strong, readonly) UIWebView *webView;
@property (nonatomic, copy) NSDictionary *source;
@property (nonatomic, copy) VZFEventBlock onLoadingStart;
@property (nonatomic, copy) VZFEventBlock onLoadingFinish;
@property (nonatomic, copy) VZFEventBlock onLoadingError;
@property (nonatomic, copy) BOOL (^onShouldStartLoadWithRequest)(NSDictionary *body);

@end
