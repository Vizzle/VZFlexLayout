//
//  VZFIndicatorView.m
//  O2OReact
//
//  Created by Sleen on 16/7/5.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFIndicatorView.h"

@implementation VZFIndicatorView

/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)willEnterReusePool
{
    [self stopAnimating];
}

@end
