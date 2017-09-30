//
//  VZFScrollView.m
//  O2OReact
//
//  Created by moxin on 16/5/13.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFScrollView.h"
#import "UIView+VZAttributes.h"
#import "VZFScrollNode.h"
#import "VZFMacros.h"

@implementation VZFScrollView


/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - backing view interface

- (void)born{
    VZFNSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)dead{
    VZFNSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)prepareForReuse{
    VZFNSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)willEnterReusePool{
    VZFNSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)didLeaveReusePool{
    VZFNSLog(@"%s",__PRETTY_FUNCTION__);
    
}


- (void)resetState{
    self.contentOffset = CGPointZero;
}

- (void)vz_applyNodeAttributes:(VZFNode *)node {
    VZFScrollNode *scrollNode = (VZFScrollNode *)node;
    ScrollNodeSpecs specs = scrollNode.scrollNodeSpecs;
    self.scrollEnabled = specs.scrollEnabled;
    self.pagingEnabled = specs.paging;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollsToTop = specs.scrollsToTop;
    self.contentSize = scrollNode.contentSize;
    [self setNeedsLayout];
}

@end
