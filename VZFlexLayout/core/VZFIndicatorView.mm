//
//  VZFIndicatorView.m
//  O2OReact
//
//  Created by Sleen on 16/7/5.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFIndicatorView.h"
#import "VZFIndicatorNode.h"
#import "UIView+VZAttributes.h"

@implementation VZFIndicatorView

/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)willEnterReusePool
{
    [self stopAnimating];
}

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    IndicatorNodeSpecs specs = ((VZFIndicatorNode *)node).indicatorSpecs;
    self.color = specs.color;
    self.transform = CGAffineTransformMakeScale(self.frame.size.width / 20, self.frame.size.height / 20);
    [self startAnimating];
}

@end
