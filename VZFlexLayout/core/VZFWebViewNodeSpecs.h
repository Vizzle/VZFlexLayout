//
//  VZFWebViewNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace VZ {
    struct WebViewNodeSpecs {
        /**
         HTML content:
         
         {
            "html": html,
            "baseUrl": baseUrl
         }
         
         URL:
         
         {
            @"url": url,
         }
         */
        NSDictionary *source;
        
        WebViewNodeSpecs copy() const {
            return {
                [source copy]
            };
        }
    };
}
