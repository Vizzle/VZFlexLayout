//
//  VZFWebViewNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZFEvent.h"

namespace VZ {
    struct WebViewNodeSpecs {
        /**
         HTML content:
         
         {
            "html": loading html content,
         
            "baseUrl": base url of html content
         }
         
         URL:
         
         {
            @"url": loading url,
         }
         */
        NSDictionary *source;
        BOOL scalesPageToFit;
        /**
         Event body:
         
         {
            @"url": web view loading url,
         
            @"loading" : web view is loading,
         
            @"canGoBack": web view canGoBack,
         
            @"canGoForward" : web view canGoForward,
         
            @"navigationType" : web view navigation type
         }
         
         */
        VZFEventBlock onLoadingStart;
        /**
         Event body:
         
         {
            @"url": web view loading url,
         
            @"loading" : web view is loading,
         
            @"canGoBack": web view canGoBack,
         
            @"canGoForward" : web view canGoForward
         }
         */
        VZFEventBlock onLoadingFinish;
        /**
         Event body:
         
         {
            @"url": web view loading url,
         
            @"loading" : web view is loading,
         
            @"canGoBack": web view canGoBack,
         
            @"canGoForward" : web view canGoForward,
         
            @"domain": error domin,
         
            @"code": error code,
         
            @"description": error description
         }
         */
        VZFEventBlock onLoadingError;
        
        BOOL (^onShouldStartLoadWithRequest)(NSDictionary *body);
        
        WebViewNodeSpecs copy() const {
            return {
                [source copy],
                scalesPageToFit,
                [onLoadingStart copy],
                [onLoadingFinish copy],
                [onLoadingError copy],
                [onShouldStartLoadWithRequest copy]
            };
        }
    };
}
